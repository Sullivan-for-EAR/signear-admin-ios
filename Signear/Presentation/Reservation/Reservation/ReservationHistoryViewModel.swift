//
//  ReservationHistoryViewModel.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation
import RxCocoa
import RxSwift

protocol ReservationHistoryViewModelInputs {
    func fetchReservationHistory()
}

protocol ReservationHistoryViewModelOutputs {
    var reservationHistory: Driver<[ReservationHistoryModel]> { get }
}

protocol ReservationHistoryViewModelType {
    var inputs: ReservationHistoryViewModelInputs { get }
    var outputs: ReservationHistoryViewModelOutputs { get }
}

class ReservationHistoryViewModel: ReservationHistoryViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let _reservationHistory: BehaviorRelay<[ReservationHistoryModel]> = .init(value: [])
    private let fetchReservationHistoryUseCase: FetchReservationHistoryUseCaseType
    
    // MARK: - Life Cycle
    
    init(fetchReservationHistoryUseCase: FetchReservationHistoryUseCaseType) {
        self.fetchReservationHistoryUseCase = fetchReservationHistoryUseCase
    }
    
    convenience init() {
        self.init(fetchReservationHistoryUseCase: FetchReservationHistoryUseCase())
    }
}

extension ReservationHistoryViewModel: ReservationHistoryViewModelInputs {
    
    var inputs: ReservationHistoryViewModelInputs { return self }
    
    func fetchReservationHistory() {
        fetchReservationHistoryUseCase.fetchReservationHistory()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let history):
                    self?._reservationHistory.accept(history)
                case .failure(_):
                    // TODO : API Error
                    break
                }
            }).disposed(by: disposeBag)
    }
}

extension ReservationHistoryViewModel: ReservationHistoryViewModelOutputs {
    
    var outputs: ReservationHistoryViewModelOutputs { return self }
    var reservationHistory: Driver<[ReservationHistoryModel]> { _reservationHistory.asDriver(onErrorJustReturn: []) }
}
