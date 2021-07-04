//
//  EmergencyDashboardCollectionViewCell.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import UIKit
import RxCocoa
import RxSwift

protocol EmergencyDashboardCollectionViewCellDelegate: AnyObject {
    func didSelectAcceptButton(_ reservationInfo: ReservationInfoModel)
}

class EmergencyDashboardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var acceptButton: UIButton!
    
    // MARK: - Properties - Internal
    
    weak var delegate: EmergencyDashboardCollectionViewCellDelegate?
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var reservationInfo: ReservationInfoModel?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - Private

extension EmergencyDashboardCollectionViewCell {
    
    private func configureUI() {
        acceptButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let reservationInfo = self.reservationInfo else { return }
                self.delegate?.didSelectAcceptButton(reservationInfo)
            }).disposed(by: disposeBag)
    }
}
