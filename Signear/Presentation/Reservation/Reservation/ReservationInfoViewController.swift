//
//  ReservationInfoViewController.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import UIKit
import RxCocoa
import RxSwift

class ReservationInfoViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var methodLabel: UILabel!
    @IBOutlet private weak var requestLabel: UILabel!
    @IBOutlet private weak var callButton: UIButton!
    
    // MARK: - Properties - Internal
    
    enum ViewType {
        case reservation
        case history
    }
    
    var viewType: ViewType!
    var reservationId: Int!
    
    // MARK: - Properties - Private
    
    private var phone: String?
    private let disposeBag = DisposeBag()
    private var viewModel: ReservationInfoViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = ReservationInfoViewModel()
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

extension ReservationInfoViewController {
    
    private func configureUI() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = .init()
        navigationItem.leftBarButtonItem = .init(image: .init(named: "leftArrowIcon"), style: .plain, target: self, action: #selector(didTappedBackButton(_:)))
        
        callButton.isHidden = viewType == .history
        callButton.layer.cornerRadius = 5
        callButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.call()
            }).disposed(by: disposeBag)
    }
    
    private func bindUI() {
        viewModel?.outputs.reservationInfo
            .drive(onNext: { [weak self] reservationInfo in
                guard let self = self,
                      let reservationInfo = reservationInfo else {
                    return
                }
                self.dateLabel.text = self.convertDateToString(date: reservationInfo.date)
                self.setTime(startTime: reservationInfo.startTime, endTime: reservationInfo.endTime)
                self.addressLabel.text = reservationInfo.address
                self.methodLabel.text = reservationInfo.method == .video ? "화상통역(비대면)" : "수어통역(대면)"
                self.requestLabel.text = reservationInfo.request
                self.phone = reservationInfo.phone
            }).disposed(by: disposeBag)
    }
    
    private func setTime(startTime: String?, endTime: String?) {
        guard let startTime = startTime,
              let endTime = endTime else {
            return
        }
        timeLabel.text = "\(convertTimeStringToDate(time: startTime).convertStringByFormat(format: "a H:mm")) ~ \(convertTimeStringToDate(time: endTime).convertStringByFormat(format: "a H:mm"))"
    }
    
    private func convertDateToString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "MMM dd일 EEEE"
        return dateFormatter.string(from: convertDate)
    }
    
    private func convertTimeStringToDate(time: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "HHmm"
        return dateFormatter.date(from: time) ?? Date()
    }
    
    private func call() {
        guard let phone = phone else {
            return
        }
        
        if let url = NSURL(string: "tel://" + phone.getArrayAfterRegex(regex: "[0-9]").joined()),
           UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
