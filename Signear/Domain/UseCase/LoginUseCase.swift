//
//  LoginUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import Foundation
import RxSwift

protocol LoginUseCaseType {
    func login(email: String, password: String) -> Observable<Bool>
}

class LoginUseCase: LoginUseCaseType {
    func login(email: String, password: String) -> Observable<Bool> {
        return .just(true)
    }
}
