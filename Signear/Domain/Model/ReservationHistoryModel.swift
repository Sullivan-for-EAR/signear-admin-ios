//
//  ReservationHistoryModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/26.
//

import UIKit

struct ReservationHistoryModel: Equatable {
    let title: String
    let date: String
    let status: ReservationHistoryStatus
}

// MARK: - Reservation Status

enum ReservationHistoryStatus {
    case finish
    case cancel
}

// MARK: - ReservationStatus Image

extension ReservationHistoryStatus {
    func getImage() -> UIImage? {
        switch self {
        case .finish:
            return UIImage.init(named: "translateFinishIcon")
        case .cancel:
            return UIImage.init(named: "translateCancelIcon")
        }
    }
}

