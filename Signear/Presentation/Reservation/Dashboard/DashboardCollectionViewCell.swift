//
//  DashboardCollectionViewCell.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/06.
//

import UIKit
import RxCocoa
import RxSwift

protocol DashboardCollectionViewCellDelegate: class {
    func didSelectMoreButton(_ dashboardCollectionViewCell: DashboardCollectionViewCell, _ reservation: ReservationModel)
}

class DashboardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Properties - Internal
    
    weak var delegate: DashboardCollectionViewCellDelegate?
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var reservation: ReservationModel?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
}

// MARK: - Internal

extension DashboardCollectionViewCell {
    func updateUI(reservation: ReservationModel) {
        self.reservation = reservation
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dateLabel.text = reservation.date
        }
    }
}

// MARK: - Private

extension DashboardCollectionViewCell {
    private func configureUI() {
        moreButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let reservation = self.reservation else { return }
                self.delegate?.didSelectMoreButton(self, reservation)
            }).disposed(by: disposeBag)
    }
}
