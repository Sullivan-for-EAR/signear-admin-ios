//
//  Date+Extension.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation

extension Date {
    func convertStringByFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
