//
//  SignearAPI.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/07.
//

import Foundation
import Alamofire
import RxSwift

class SignearAPI {
    
    // MARK: - Properties - Static
    
    static let shared = SignearAPI()
    
    // MARK: - Properties - Internal
    
    enum Constants {
        static let baseURL = "3.35.204.9:80"
        static let checkEmail = "/sign/check"
    }
}
