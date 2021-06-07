//
//  FindAccountViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import Foundation

protocol FindAccountViewModelInputs {
}

protocol FindAccountViewModelOutputs {
}

protocol FindAccountViewModelType {
    var inputs: FindAccountViewModelInputs { get }
    var outputs: FindAccountViewModelOutputs { get }
}

class FindAccountViewModel: FindAccountViewModelType {
    
}

// MARK : FindAccountViewModelInputs

extension FindAccountViewModel: FindAccountViewModelInputs {
    
    var inputs: FindAccountViewModelInputs { return self }
}

// MARK : FindAccountViewModelOutputs

extension FindAccountViewModel: FindAccountViewModelOutputs {
    
    var outputs: FindAccountViewModelOutputs { return self }
}
