//
//  FetchReservationHistoryUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/26.
//

import Foundation
import RxSwift

protocol FetchReservationHistoryUseCaseType {
    func fetchReservationHistory() -> Observable<Result<[ReservationHistoryModel], APIError>>
}

class FetchReservationHistoryUseCase: FetchReservationHistoryUseCaseType {
    
    func fetchReservationHistory() -> Observable<Result<[ReservationHistoryModel], APIError>> {
        // TODO : API 적용
        return SignearAPI.shared.fetchReservationHistory()
            .map { result in
                switch result {
                case .success(let history):
                    return .success(history.map { $0.toDomain() } )
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
