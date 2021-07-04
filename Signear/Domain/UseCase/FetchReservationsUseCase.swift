//
//  FetchReservationsUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/22.
//

import Foundation
import RxSwift

protocol FetchReservationsUseCaseType {
    func fetchReservations() -> Observable<Result<[ReservationModel], APIError>>
}

class FetchReservationsUseCase: FetchReservationsUseCaseType {
    func fetchReservations() -> Observable<Result<[ReservationModel], APIError>> {
        return SignearAPI.shared.fetchReservations()
            .map { response in
                switch response {
                case .success(let list):
                    return .success(list.map { $0.toDomain() })
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
