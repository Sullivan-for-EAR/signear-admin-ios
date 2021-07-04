//
//  DashboardCollectionViewCell.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/06.
//

import UIKit
import RxCocoa
import RxSwift

protocol DashboardCollectionViewCellDelegate: AnyObject {
    func didSelectMoreButton(_ dashboardCollectionViewCell: DashboardCollectionViewCell, _ reservation: ReservationModel)
}

class DashboardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Properties - Internal
    
    weak var delegate: DashboardCollectionViewCellDelegate?
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var reservation: ReservationModel?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - Internal

extension DashboardCollectionViewCell {
    func updateUI(reservation: ReservationModel) {
        self.reservation = reservation
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setDate(date: reservation.date)
            self.setTime(startTime: reservation.startTime, endTime: reservation.endTime)
            self.setMethod(method: reservation.method)
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
        dateFormatter.dateFormat = "a H시 mm분"
        timeLabel.text = "\(dateFormatter.string(from: startDate)) ~ \(dateFormatter.string(from: endDate))"
    }
    
    private func setMethod(method: ReservationModel.MeetingType?) {
        switch method {
        case .sign:
            typeLabel.text = "수어통역(대면)"
        case .video:
            typeLabel.text = "화상통역(비대면)"
        default:
            break
        }
    }
}
