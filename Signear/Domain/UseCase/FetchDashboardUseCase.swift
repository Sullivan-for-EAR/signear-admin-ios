//
//  FetchDashboardUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/06.
//

import Foundation
import RxSwift

protocol FetchDashboardUseCaseType {
    func execute() -> Observable<[ReservationModel]>
}

class FetchDashboardUseCase: FetchDashboardUseCaseType {
    
    func execute() -> Observable<[ReservationModel]> {
        return .just([])
    }
}
