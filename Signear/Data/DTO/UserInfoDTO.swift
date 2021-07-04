//
//  UserInfoDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation

enum UserInfoDTO {
    struct Request: Encodable {
        let signId: String
        
        private enum CodingKeys: String, CodingKey {
            case signId = "sign_id"
        }
    }
    
    struct Response: Decodable {
        let signId: Int
        let email: String
        let address: String
        
        private enum CodingKeys: String, CodingKey {
            case signId = "signID"
            case email
            case address
        }
    }
}
