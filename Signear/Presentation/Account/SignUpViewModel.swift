//
//  SignUpViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import Foundation

protocol SignUpViewModelInputs {
}

protocol SignUpViewModelOutputs {
}

protocol SignUpViewModelType {
    var inputs: SignUpViewModelInputs { get }
    var outputs: SignUpViewModelOutputs { get }
}

class SignUpViewModel: SignUpViewModelType {
}

extension SignUpViewModel: SignUpViewModelInputs {
    var inputs: SignUpViewModelInputs { return self }
}

extension SignUpViewModel: SignUpViewModelOutputs {
    var outputs: SignUpViewModelOutputs { return self }
}
