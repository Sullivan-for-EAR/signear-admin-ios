//
//  FetchProfileUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/26.
//

import Foundation
import RxSwift

protocol FetchProfileUseCaseType {
    func fetchProfile() -> Observable<ProfileModel>
}

class FetchProfileUseCase: FetchProfileUseCaseType {
    func fetchProfile() -> Observable<ProfileModel> {
        // TODO : Change Test Model
        return .just(.init())
    }
}
