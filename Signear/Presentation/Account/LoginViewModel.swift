//
//  LoginViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import Foundation
import RxCocoa
import RxSwift

protocol LoginViewModelInputs {
    func login(email: String, password: String)
}

protocol LoginViewModelOutputs {
    var loginResult: Driver<Bool> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel: LoginViewModelType {
    private let disposeBag = DisposeBag()
    private let useCase = LoginUseCase()
    private let _loginResult: PublishRelay<Bool> = .init()
}

// MARK : LoginViewModelInputs

extension LoginViewModel: LoginViewModelInputs {
    var inputs: LoginViewModelInputs { return self }
    func login(email: String, password: String) {
        useCase.login(email: email, password: password)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(_):
                    self?._loginResult.accept(true)
                    break
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }
}

// MARK : LoginViewModelOutputs

extension LoginViewModel: LoginViewModelOutputs {
    var outputs: LoginViewModelOutputs { return self }
    var loginResult: Driver<Bool> { _loginResult.asDriver(onErrorJustReturn: false) }
}
