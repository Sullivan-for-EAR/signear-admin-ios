//
//  CheckEmailRepository.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/07.
//

import Foundation
import RxSwift

protocol CheckEmailRepository {
    func checkEmail(_ email: String) -> Observable<CheckEmailDTO.Response>
}
