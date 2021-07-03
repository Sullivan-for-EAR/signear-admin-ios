//
//  CheckEmailUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/05/31.
//

import Foundation
import RxSwift

protocol EmailCheckUseCaseType {
    func checkEmail(with email: String) -> Observable<Result<Bool, APIError>>
}

class EmailCheckUseCase: EmailCheckUseCaseType {
    func checkEmail(with email: String) -> Observable<Result<Bool, APIError>> {
        return SignearAPI.shared.checkEmail(email)
            .map { result in
                switch result {
                case .success(let isExsit):
                    return .success(isExsit.isNext)
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
