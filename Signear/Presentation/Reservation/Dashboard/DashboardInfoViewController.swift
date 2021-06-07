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
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var purposeLabel: UILabel!
    @IBOutlet private weak var callButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var acceptButton: UIButton!
    
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
        viewModel?.inputs.fetchReservationInfo()
    }
}

// MARK: - Private

extension DashboardInfoViewController {
    private func configureUI() {
        callButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.call()
            }).disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.cancel()
            }).disposed(by: disposeBag)
        
        acceptButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.accept()
            }).disposed(by: disposeBag)
    }
    
    private func bindUI() {
        viewModel?.outputs.reservation
            .drive(onNext: { [weak self] reservationInfo in
                self?.updateUI(reservationInfo: reservationInfo)
            }).disposed(by: disposeBag)
    }
    
    private func updateUI(reservationInfo: ReservationInfoModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dateLabel.text = reservationInfo.date
            self.timeLabel.text = reservationInfo.time
            self.locationLabel.text = reservationInfo.location
            self.typeLabel.text = reservationInfo.type
            self.purposeLabel.text = reservationInfo.purpose
        }
    }
    
    private func call() {
        
    }
    
    private func cancel() {
        
    }
    
    private func accept() {
        
    }
}

