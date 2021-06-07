//
//  LostEmailUseCase.swift
//  signear
//
//  Created by 홍필화 on 2021/05/09.
//

import Foundation

protocol LostEmailUseCaseType {
    func sendResetPasswordEmail(to email: String)
}

class LostEmailUseCase: LostEmailUseCaseType {
    func sendResetPasswordEmail(to email: String) {
        // TODO
    }
    
}
