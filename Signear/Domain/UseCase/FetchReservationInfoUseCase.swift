//
//  FetchReservationInfoUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/30.
//

import Foundation
import RxSwift

protocol FetchReservationInfoUseCaseType {
    func fetchReservationInfo(reservationId: Int) -> Observable<Result<ReservationInfoModel, APIError>>
}

class FetchReservationInfoUseCase: FetchReservationInfoUseCaseType {
    func fetchReservationInfo(reservationId: Int) -> Observable<Result<ReservationInfoModel, APIError>> {
        return SignearAPI.shared.fetchReservationInfo(reservationId: reservationId)
            .map { response in
                switch response {
                case .success(let data):
                    return .success(data.toDomain())
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
