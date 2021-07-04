//
//  RejectReservationUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation
import RxSwift

protocol RejectReservationUseCaseType {
    func reject(reservationId: Int, reject: String?) -> Observable<Result<Bool, APIError>>
}

class RejectReservationUseCase: RejectReservationUseCaseType {
    
    func reject(reservationId: Int, reject: String?) -> Observable<Result<Bool, APIError>> {
        return SignearAPI.shared.rejectReservation(reservationId: reservationId)
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
