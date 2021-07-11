//
//  FetchDashboardDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum FetchDashboardDTO {
    
    struct Request: Codable {
        let signId: String
        
        enum CodingKeys: String, CodingKey {
            case signId = "sign_id"
        }
    }
}
