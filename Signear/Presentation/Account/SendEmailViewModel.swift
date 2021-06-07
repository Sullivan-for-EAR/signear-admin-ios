//
//  SendEmailViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/11.
//

import Foundation

protocol SendEmailViewModelInputs {
}

protocol SendEmailViewModelOutputs {
}

protocol SendEmailViewModelType {
    var inputs: SendEmailViewModelInputs { get }
    var outputs: SendEmailViewModelOutputs { get }
}

class SendEmailViewModel: SendEmailViewModelType {
    
}

extension SendEmailViewModel: SendEmailViewModelInputs {
    var inputs: SendEmailViewModelInputs { return self }
}

extension SendEmailViewModel: SendEmailViewModelOutputs {
    var outputs: SendEmailViewModelOutputs { return self }
}
