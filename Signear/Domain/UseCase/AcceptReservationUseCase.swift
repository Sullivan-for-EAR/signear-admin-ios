//
//  AcceptReservationUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation
import RxSwift

protocol AcceptReservationUseCaseType {
    func accept(reservationId: Int) -> Observable<Result<Bool, APIError>>
}

class AcceptReservationUseCase: AcceptReservationUseCaseType {
    
    func accept(reservationId: Int) -> Observable<Result<Bool, APIError>> {
        return SignearAPI.shared.acceptReservation(reservationId: reservationId)
            .map { response in
                switch response {
                case .success(_):
                    return .success(true)
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
