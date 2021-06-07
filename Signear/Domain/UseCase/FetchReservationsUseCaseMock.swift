//
//  FetchReservationsUseCaseMock.swift
//  signear
//
//  Created by 신정섭 on 2021/05/22.
//

import Foundation
import RxCocoa
import RxSwift

class FetchReservationsUseCaseMock: FetchReservationsUseCaseType {
    
    var callsCount: Int = 0
    var result: Observable<[ReservationModel]>!
    
    func fetchReservations() -> Observable<[ReservationModel]> {
        callsCount += 1
        return result
    }
}
