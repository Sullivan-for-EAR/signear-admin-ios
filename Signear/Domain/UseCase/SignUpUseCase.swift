//
//  SignUpUseCase.swift
//  signear
//
//  Created by 홍필화 on 2021/05/09.
//

import Foundation
import RxSwift

protocol SignUpUseCaseType {
    func signUp(email:String, password: String, address: String) -> Observable<Result<Bool, APIError>>
}

class SignUpUseCase: SignUpUseCaseType {
    func signUp(email:String, password: String, address: String) -> Observable<Result<Bool, APIError>> {
        return SignearAPI.shared.signUp(email: email, password: password, address: address)
            .map { response in
                switch response {
                case .success(_):
                    return .success(true)
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
