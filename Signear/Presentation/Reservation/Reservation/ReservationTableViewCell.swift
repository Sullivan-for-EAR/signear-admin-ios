//
//  ReservationTableViewCell.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var firstDescriptionImageView: UIImageView!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionImageView: UIImageView!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Internal

extension ReservationTableViewCell {
    func setReservation(_ reservation: ReservationModel) {
        let date = reservation.date
        if date == Date().convertStringByFormat(format: "yyyy-MM-dd") {
            DispatchQueue.main.async { [weak self] in
                self?.showTodayReservation(reservation)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                switch reservation.method {
                case .sign:
                    self?.showFutureSignReservation(reservation)
                case .video:
                    self?.showFutureVideoReservation(reservation)
                default:
                    break
                }
            }
        }
    }
}

// MARK: - Private

extension ReservationTableViewCell {
    
    private func showTodayReservation(_ reservation: ReservationModel) {
        guard let startTime = reservation.startTime,
              let endTime = reservation.endTime else {
            return
        }
        titleLabel.text = "오늘 \(convertTimeStringToDate(time: startTime).convertStringByFormat(format: "a H:mm")) ~ \(convertTimeStringToDate(time: endTime).convertStringByFormat(format: "a H:mm"))"
        firstDescriptionImageView.image = .init(named: "locationIcon")
        firstDescriptionLabel.text = reservation.address
        secondDescriptionImageView.image = .init(named: "purposeIcon")
        secondDescriptionLabel.text = reservation.request
        typeImageView.image = reservation.method == .sign ? .init(named: "signMarkIcon") : .init(named: "videoMarkIcon")
    }
    
    private func showFutureSignReservation(_ reservation: ReservationModel) {
        guard let startTime = reservation.startTime,
              let endTime = reservation.endTime else {
            return
        }
        titleLabel.text = convertDateToString(date: reservation.date)
        firstDescriptionImageView.image = .init(named: "timeIcon")
        firstDescriptionLabel.text = "\(convertTimeStringToDate(time: startTime).convertStringByFormat(format: "a H:mm")) ~ \(convertTimeStringToDate(time: endTime).convertStringByFormat(format: "a H:mm"))"
        secondDescriptionImageView.image = .init(named: "locationIcon")
        secondDescriptionLabel.text = reservation.address
        typeImageView.image = .init(named: "signMarkIcon")
    }
    
    private func showFutureVideoReservation(_ reservation: ReservationModel) {
        guard let startTime = reservation.startTime,
              let endTime = reservation.endTime else {
            return
        }
        titleLabel.text = convertDateToString(date: reservation.date)
        firstDescriptionImageView.image = .init(named: "timeIcon")
        firstDescriptionLabel.text = "\(convertTimeStringToDate(time: startTime).convertStringByFormat(format: "a H:mm")) ~ \(convertTimeStringToDate(time: endTime).convertStringByFormat(format: "a H:mm"))"
        secondDescriptionImageView.image = .init(named: "purposeIcon")
        secondDescriptionLabel.text = reservation.request
        typeImageView.image = .init(named: "videoMarkIcon")
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
}

