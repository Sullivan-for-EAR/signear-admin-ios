//
//  ReservationHistoryTableViewCell.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import UIKit

class ReservationHistoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var statusImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Internal

extension ReservationHistoryTableViewCell {
    
    func setHistory(_ history: ReservationHistoryModel) {
        var date = convertDateToString(date: history.date)
        if let startTime = history.startTime {
            date.append(" ")
            date.append(convertTimeStringToDate(time: startTime).convertStringByFormat(format: "a h시 mm분"))
        }
        dateLabel.text = date
        addressLabel.text = history.address
        statusImageView.image = history.status.getImage()
    }
}

// MARK: - Private

extension ReservationHistoryTableViewCell {
    
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
