//
//  HelloViewModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/11.
//

import Foundation

protocol HelloViewModelInputs {
}

protocol HelloViewModeloutputs {
}

protocol HelloViewModelType {
    var inputs: HelloViewModelInputs { get }
    var outputs: HelloViewModeloutputs { get }
}

class HelloViewModel: HelloViewModelType {
    
}

extension HelloViewModel: HelloViewModelInputs {
    var inputs: HelloViewModelInputs { return self }
}

extension HelloViewModel: HelloViewModeloutputs {
    var outputs: HelloViewModeloutputs { return self }
}
