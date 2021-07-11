//
//  ReservationInfoModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/30.
//

import Foundation

struct ReservationInfoModel: Equatable {
    let rsID: Int
    let date: String
    let startTime: String?
    let endTime: String?
    let area: String?
    let address: String?
    let method: MeetingType
    let status: Status
    let type: CallType
    let request: String?
    let reject: String?
    let phone: String
}

extension ReservationInfoModel {
    // 수어통역 : 1, 화상통역:2
    enum MeetingType: Int {
        case error = 0
        case sign = 1
        case video = 2
    }
    
    // 1:읽지않음, 2:센터확인중, 3:예약확정, 4.예약취소,
    // 5:예약거절, 6: 통역취소, 7:통역 완료, 8: 긴급통역 연결중, 9: 긴급통역 취소, 10: 긴급통역 승인
    enum Status: Int {
        case error = 0
        case unread = 1
        case check = 2
        case confirm = 3
        case cancel = 4
        case reject = 5
        case cancelToTranslation = 6
        case complete = 7
        case connectToEmergencyCall = 8
        case cancelToEmergencyCall = 9
        case confirmToEmergencyCall = 10
    }
    
    // 1:일반, 2:긴급
    enum CallType: Int {
        case error = 0
        case normal = 1
        case emergency = 2
    }
}
