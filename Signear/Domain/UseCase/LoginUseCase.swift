//
//  LoginUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import Foundation
import RxSwift

protocol LoginUseCaseType {
    func login(email: String, password: String) -> Observable<Result<Bool, APIError>>
}

class LoginUseCase: LoginUseCaseType {
    func login(email: String, password: String) -> Observable<Result<Bool, APIError>> {
        return SignearAPI.shared.login(email: email, password: password)
            .map { result in
                switch result {
                case .success(_):
                    return .success(true)
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
