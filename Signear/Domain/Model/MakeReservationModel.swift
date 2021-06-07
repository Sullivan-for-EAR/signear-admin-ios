//
//  MakeReservationModel.swift
//  signear
//
//  Created by 홍필화 on 2021/05/23.
//

import UIKit

struct MakeReservationModel: Equatable {
    let date: String
    let startTime: String
    let endTime: String
    let center: String
    let location: String
    let requests: String
    let type: ReservationType
}

enum ReservationType {
    case offline
    case online
}
