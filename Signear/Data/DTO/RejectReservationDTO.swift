//
//  RejectReservationDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum RejectReservationDTO {
    struct Request: Encodable {
        let signId: String
        
        private enum CodingKeys: String, CodingKey {
            case signId = "sign_id"
        }
    }
    
    struct Response: Decodable {
        let rsID: Int
    }
}
