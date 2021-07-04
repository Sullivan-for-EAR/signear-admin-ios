//
//  FetchReservationsDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum FetchReservationsDTO {
    
    struct Request: Codable {
        let signId: Int
        
        enum CodingKeys: String, CodingKey {
            case signId = "sign_id"
        }
    }
}
