//
//  FetchReservationHistoryUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/26.
//

import Foundation
import RxSwift

protocol FetchReservationHistoryUseCaseType {
    func fetchReservationHistory() -> Observable<[ReservationHistoryModel]>
}

class FetchReservationHistoryUseCase: FetchReservationHistoryUseCaseType {
    
    func fetchReservationHistory() -> Observable<[ReservationHistoryModel]> {
        // TODO : API 적용
        return .just([])
    }
}
