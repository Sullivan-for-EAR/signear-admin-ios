//
//  SignUpViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import Foundation
import RxCocoa
import RxSwift

protocol SignUpViewModelInputs {
    func fetchArea()
    func signUp(email: String, password: String, address: String)
}

protocol SignUpViewModelOutputs {
    var area: Driver<[String]> { get }
    var signUpResult: Driver<Bool> { get }
}

protocol SignUpViewModelType {
    var inputs: SignUpViewModelInputs { get }
    var outputs: SignUpViewModelOutputs { get }
}

class SignUpViewModel: SignUpViewModelType {
    private let disposeBag = DisposeBag()
    private var _area: PublishRelay<[String]> = .init()
    private let fetchAreaUseCase = FetchAreaUseCase()
    private let useCase = SignUpUseCase()
    private let _signUpResult: PublishRelay<Bool> = .init()
}

extension SignUpViewModel: SignUpViewModelInputs {
    
    var inputs: SignUpViewModelInputs { return self }
    
    func fetchArea() {
        fetchAreaUseCase.fetchArea()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let area):
                    self?._area.accept(area)
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    func signUp(email: String, password: String, address: String) {
        useCase.signUp(email: email, password: password, address: address)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let result):
                    self?._signUpResult.accept(result)
                case .failure(_):
                    // TODO: error 처리
                    return
                }
            }).disposed(by: disposeBag)
    }
}

extension SignUpViewModel: SignUpViewModelOutputs {
    var outputs: SignUpViewModelOutputs { return self }
    var area: Driver<[String]> { _area.asDriver(onErrorJustReturn: []) }
    var signUpResult: Driver<Bool> { _signUpResult.asDriver(onErrorJustReturn: false) }
}
