//
//  MyPageViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/25.
//

import Foundation
import RxCocoa
import RxSwift

protocol MyPageViewModelInputs {
    func fetchProfile()
}

protocol MyPageViewModelOutputs {
    var profile: Driver<ProfileModel> { get }
}

protocol MyPageViewModelType {
    var inputs: MyPageViewModelInputs { get }
    var outputs: MyPageViewModelOutputs { get }
}

class MyPageViewModel: MyPageViewModelType {
    
    // MARK: - Properties - Private
    
    private let useCase: FetchProfileUseCaseType
    private let disposeBag = DisposeBag()
    private var _profile: PublishRelay<ProfileModel> = .init()
    
    init(useCase: FetchProfileUseCaseType) {
        self.useCase = useCase
    }
    
    convenience init() {
        self.init(useCase: FetchProfileUseCase())
    }
}

// MARK: MyPageViewModelInputs

extension MyPageViewModel: MyPageViewModelInputs {
    
    var inputs: MyPageViewModelInputs { return self }
    
    func fetchProfile() {
        useCase.fetchProfile()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let profile):
                    self?._profile.accept(profile)
                case .failure(_):
                    // TODO : API Error
                    break
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: MyPageViewModelOutputs

extension MyPageViewModel: MyPageViewModelOutputs {
    
    var outputs: MyPageViewModelOutputs { return self }
    var profile: Driver<ProfileModel> { _profile.asDriver(onErrorJustReturn: .init()) }
}
