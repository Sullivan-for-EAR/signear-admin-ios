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
    var email: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
    var login: PublishRelay<Void> { get }
}

protocol LoginViewModelOutputs {
    var isValidAccountType: Driver<Bool> { get }
    var loginResult: Driver<Bool> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel: LoginViewModelType {
    
    // MARK: - Properties - Private
    
    private let useCase: LoginUseCaseType
    private let disposeBag = DisposeBag()
    private let _email: BehaviorRelay<String?> = .init(value: nil)
    private let _password: BehaviorRelay<String?> = .init(value: nil)
    private let _login: PublishRelay<Void> = .init()
    private let _isValidAccountType: BehaviorRelay<Bool> = .init(value: false)
    private let _loginResult: PublishRelay<Bool> = .init()
    
    init(useCase: LoginUseCaseType) {
        self.useCase = useCase
        email.subscribe(onNext: { [weak self] email in
            self?.updateLoginButton()
        }).disposed(by: disposeBag)
        
        password.subscribe(onNext: { [weak self] password in
            self?.updateLoginButton()
        }).disposed(by: disposeBag)
        
        login.subscribe(onNext: { [weak self] in
            guard let self = self,
                  let email = self.email.value,
                  let password = self.password.value else {
                return
            }
            self.useCase.login(email: email, password: password)
                .bind(to: self._loginResult)
                .disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
    }
    
    convenience init() {
        self.init(useCase: LoginUseCase())
    }
}

// MARK: - Private

extension LoginViewModel {
    private func updateLoginButton() {
        guard let email = email.value,
              let password = password.value,
              email.isValidEmail(),
              password.isNotEmpty else {
            _isValidAccountType.accept(false)
            return
        }
        _isValidAccountType.accept(true)
    }
}

// MARK : LoginViewModelInputs

extension LoginViewModel: LoginViewModelInputs {
    
    var inputs: LoginViewModelInputs { return self }
    var email: BehaviorRelay<String?> { _email }
    var password: BehaviorRelay<String?> { _password }
    var login: PublishRelay<Void> { _login }
}

// MARK : LoginViewModelOutputs

extension LoginViewModel: LoginViewModelOutputs {
    var outputs: LoginViewModelOutputs { return self }
    var isValidAccountType: Driver<Bool> { _isValidAccountType.asDriver(onErrorJustReturn: false) }
    var loginResult: Driver<Bool> { _loginResult.asDriver(onErrorJustReturn: false) }
}
