//
//  CheckEmailUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/05/31.
//

import Foundation
import RxSwift

protocol CheckEmailUseCaseType {
    func checkEmail(_ email: String) -> Observable<Bool>
}

class CheckEmailUseCase: CheckEmailUseCaseType {
    func checkEmail(_ email: String) -> Observable<Bool> {
        return .just(true)
    }
}
