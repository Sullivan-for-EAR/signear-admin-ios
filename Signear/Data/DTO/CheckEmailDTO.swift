//
//  CheckEmailDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/07.
//

import Foundation

enum CheckEmailDTO {
    struct Request: Codable {
        let email: String
    }
    
    struct Response: Codable {
        let isNext: Bool
    }
}
