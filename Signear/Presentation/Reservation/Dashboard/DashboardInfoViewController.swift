//
//  DashboardInfoViewController.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/06.
//

import UIKit
import RxCocoa
import RxSwift

class DashboardInfoViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var requestLabel: UILabel!
    @IBOutlet private weak var callButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var acceptButton: UIButton!
    
    // MARK: - Properties - Internal
    
    var reservationId: Int!
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var viewModel: DashboardInfoViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = DashboardInfoViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        viewModel?.inputs.fetchReservationInfo(reservationId: reservationId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Actions
    
    @objc private func didTappedBackButton(_ button: UINavigationItem) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private

extension DashboardInfoViewController {
    private func configureUI() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = .init()
        navigationItem.leftBarButtonItem = .init(image: .init(named: "leftArrowIcon"), style: .plain, target: self, action: #selector(didTappedBackButton(_:)))
        
        callButton.layer.borderWidth = 2
        callButton.layer.borderColor = UIColor.black.cgColor
        callButton.layer.cornerRadius = 5
        callButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.showCallAlertView()
            }).disposed(by: disposeBag)
        
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = UIColor.init(rgb: 0xFF453A).cgColor
        cancelButton.layer.cornerRadius = 5
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.showCancelAlertView()
            }).disposed(by: disposeBag)
        
        acceptButton.layer.cornerRadius = 5
        acceptButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.showAcceptAlertView()
            }).disposed(by: disposeBag)
    }
    
    private func bindUI() {
        viewModel?.outputs.reservationInfo
            .drive(onNext: { [weak self] reservationInfo in
                guard let self = self,
                      let reservationInfo = reservationInfo else {
                    return
                }
                self.setDate(date: reservationInfo.date)
                self.setTime(startTime: reservationInfo.startTime, endTime: reservationInfo.endTime)
                self.addressLabel.text = reservationInfo.address
                self.setMethod(method: reservationInfo.method)
                self.requestLabel.text = reservationInfo.request
            }).disposed(by: disposeBag)
        
        viewModel?.outputs.acceptResult
            .drive(onNext: { [weak self] result in
                if result {
                    self?.navigationController?.popViewController(animated: true)
                }
            }).disposed(by: disposeBag)
        
        viewModel?.outputs.rejectResult
            .drive(onNext: { [weak self] result in
                if result {
                    self?.navigationController?.popViewController(animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    private func setDate(date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "MMM dd일 EEEE"
        dateLabel.text = dateFormatter.string(from: convertDate)
    }
    
    private func setTime(startTime: String?, endTime: String?) {
        guard let startTime = startTime,
              let endTime = endTime else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "HHmm"
        let startDate = dateFormatter.date(from: startTime) ?? Date()
        let endDate = dateFormatter.date(from: endTime) ?? Date()
        dateFormatter.dateFormat = "a h시 mm분"
        timeLabel.text = "\(dateFormatter.string(from: startDate)) ~ \(dateFormatter.string(from: endDate))"
    }
    
    private func setMethod(method: ReservationInfoModel.MeetingType) {
        switch method {
        case .sign:
            typeLabel.text = "수어통역(대면)"
        case .video:
            typeLabel.text = "화상통역(비대면)"
        default:
            break
        }
    }
    
    private func showCallAlertView() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "음성전화 걸기", style: .default, handler: { [weak self] _ in
        }))
        alert.addAction(UIAlertAction(title: "영상전화 걸기", style: .default, handler: { [weak self] _ in
        }))
        alert.addAction(UIAlertAction(title: "문자 보내기", style: .default, handler: { [weak self] _ in
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showCancelAlertView() {
        let alert = UIAlertController(title: "예약 거절",
                                      message: "예약자에게 전달할 거절 사유를 입력해주세요.",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let self = self,
                  let rejectTextField = alert.textFields?.first else {
                return
            }
            self.viewModel?.inputs.reject(reservationId: self.reservationId, message: rejectTextField.text)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAcceptAlertView() {
        guard let date = dateLabel.text,
              let startTime = timeLabel.text?.components(separatedBy: " ~ ").first else { return }
        let alert = UIAlertController(title: "예약 승인",
                                      message: "\(date) \(startTime) 예약을 승인하시나요?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.inputs.accept(reservationId: self.reservationId)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

