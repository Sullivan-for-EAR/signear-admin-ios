//
//  CancelReservationUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/30.
//

import Foundation
import RxSwift

protocol CancelReservationUseCaseType {
    func cancelReservation() -> Observable<Bool>
}

class CancelReservationUseCase: CancelReservationUseCaseType {
    func cancelReservation() -> Observable<Bool> {
        // TODO : API
        return .just(true)
    }
}
