//
//  EmailCheckViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/05.
//

import Foundation
import RxCocoa
import RxSwift

protocol EmailCheckViewModelInputs {
    func setEmail(_ email: String?)
    func checkEmail()
}

protocol EmailCheckViewModelOutputs {
    var isValidEmailType: Driver<Bool> { get }
    var checkEmailResult: Driver<String?> { get }
}

protocol EmailCheckViewModelType {
    var inputs: EmailCheckViewModelInputs { get }
    var outputs: EmailCheckViewModelOutputs { get }
}

class EmailCheckViewModel: EmailCheckViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let useCase: CheckEmailUseCaseType
    private var email: String? = nil
    private var _isValidEmailType: BehaviorRelay<Bool> = .init(value: false)
    private var _checkEmailResult: PublishRelay<String?> = .init()
    
    init(useCase: CheckEmailUseCaseType) {
        self.useCase = useCase
    }
    
    convenience init() {
        self.init(useCase: CheckEmailUseCase())
    }
}

// MARK: - EmailCheckViewModelInputs

extension EmailCheckViewModel: EmailCheckViewModelInputs {

    var inputs: EmailCheckViewModelInputs { return self }
    
    func setEmail(_ email: String?) {
        self.email = email
        _isValidEmailType.accept(email?.isValidEmail() ?? false)
    }
    
    func checkEmail() {
        guard let email = email else { return }
        useCase.checkEmail(email)
            .subscribe(onNext: { [weak self] result in
                self?._checkEmailResult.accept(email)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - EmailCheckViewModelOutputs

extension EmailCheckViewModel: EmailCheckViewModelOutputs {
    
    var outputs: EmailCheckViewModelOutputs { return self }
    
    var isValidEmailType: Driver<Bool> { _isValidEmailType.asDriver(onErrorJustReturn: false) }
    var checkEmailResult: Driver<String?> { _checkEmailResult.asDriver(onErrorJustReturn: nil) }
}
