//
//  FetchProfileUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/26.
//

import Foundation
import RxSwift

protocol FetchProfileUseCaseType {
    func fetchProfile() -> Observable<Result<ProfileModel, APIError>>
}

class FetchProfileUseCase: FetchProfileUseCaseType {
    func fetchProfile() -> Observable<Result<ProfileModel, APIError>> {
        return SignearAPI.shared.getUserInfo()
            .map { result in
                switch result {
                case .success(let response):
                    return .success(.init(name: response.email, address: response.address))
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
