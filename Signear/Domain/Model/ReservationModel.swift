//
//  ReservationModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/22.
//

import UIKit

struct ReservationModel: Equatable {
    let title: String
    let date: String
    let status: ReservationStatus
}

// MARK: - Reservation Status

enum ReservationStatus {
    case unread
    case check
    case confirm
    case reject
}

// MARK: - ReservationStatus Image

extension ReservationStatus {
    func getImage() -> UIImage? {
        switch self {
        case .unread:
            return UIImage.init(named: "unreadReservationIcon")
        case .check:
            return UIImage.init(named: "checkReservationIcon")
        case .confirm:
            return UIImage.init(named: "confirmReservationIcon")
        case .reject:
            return UIImage.init(named: "rejectReservationIcon")
        }
    }
}
