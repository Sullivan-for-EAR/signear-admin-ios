//
//  FetchReservationInfoUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/30.
//

import Foundation
import RxSwift

protocol FetchReservationInfoUseCaseType {
    func fetchReservationInfo() -> Observable<ReservationInfoModel>
}

class FetchReservationInfoUseCase: FetchReservationInfoUseCaseType {
    
    func fetchReservationInfo() -> Observable<ReservationInfoModel> {
        // TODO : API
        return .just(.init())
    }
}
