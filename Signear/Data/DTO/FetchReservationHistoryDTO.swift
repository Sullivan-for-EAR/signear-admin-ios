//
//  FetchReservationHistoryDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation

enum FetchReservationHistoryDTO {
    struct Request: Encodable {
        let signId: String
        
        private enum CodingKeys: String, CodingKey {
            case signId = "sign_id"
        }
    }
}
