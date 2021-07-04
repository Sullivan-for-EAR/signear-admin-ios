//
//  FetchDashboardUseCase.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/06.
//

import Foundation
import RxSwift

protocol FetchDashboardUseCaseType {
    func fetchDashboard() -> Observable<Result<[ReservationModel], APIError>>
}

class FetchDashboardUseCase: FetchDashboardUseCaseType {
    func fetchDashboard() -> Observable<Result<[ReservationModel], APIError>> {
        return SignearAPI.shared.fetchDashboard()
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
