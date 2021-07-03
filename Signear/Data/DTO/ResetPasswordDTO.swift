//
//  ResetPasswordDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum ResetPasswordDTO {
    struct Request: Codable {
        let email: String
    }
}
