//
//  SignUpDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum SignUpDTO {
    struct Request: Codable {
        let email: String
        let password: String
        let address: String
    }
    
    struct Response: Codable {
        let accessToken: String
        let userProfile: userProfile
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case userProfile
        }
    }
    
    struct userProfile: Codable {
        let signID: Int
    }
}
