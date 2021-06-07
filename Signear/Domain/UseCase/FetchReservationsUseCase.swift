//
//  FetchReservationsUseCase.swift
//  signear
//
//  Created by 신정섭 on 2021/05/22.
//

import Foundation
import RxSwift

protocol FetchReservationsUseCaseType {
    func fetchReservations() -> Observable<[ReservationModel]>
}

class FetchReservationsUseCase: FetchReservationsUseCaseType {
    
    func fetchReservations() -> Observable<[ReservationModel]> {
        // TODO : API 연결
        let list = [ReservationModel(title: "Title1", date: "Data1", status: .unread),
                    ReservationModel(title: "Title2", date: "Data2", status: .check),
                    ReservationModel(title: "Title3", date: "Data3", status: .confirm),
                    ReservationModel(title: "Title4", date: "Data4", status: .reject)]
        return .just(list)
    }
}
