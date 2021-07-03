//
//  LoginDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum LoginDTO {
    struct Request: Codable {
        let email: String
        let password: String
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
