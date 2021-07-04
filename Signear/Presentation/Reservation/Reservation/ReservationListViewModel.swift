//
//  ReservationListViewModel.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation
import RxCocoa
import RxSwift

protocol ReservationListViewModelInputs {
    func fetchReservations()
}

protocol ReservationListViewModelOutputs {
    var reservations: Driver<[ReservationModel]> { get }
}

protocol ReservationListViewModelType {
    var inputs: ReservationListViewModelInputs { get }
    var outputs: ReservationListViewModelOutputs { get }
}

class ReservationListViewModel: ReservationListViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let fetchReservationsUseCase: FetchReservationsUseCaseType
    private let _reservations: BehaviorRelay<[ReservationModel]> = .init(value: [])
    
    // MARK: - Life Cycle
    
    init(fetchReservationsUseCase: FetchReservationsUseCaseType) {
        self.fetchReservationsUseCase = fetchReservationsUseCase
    }
    
    convenience init() {
        self.init(fetchReservationsUseCase: FetchReservationsUseCase())
    }
}

extension ReservationListViewModel: ReservationListViewModelInputs {
    var inputs: ReservationListViewModelInputs { return self }
    
    func fetchReservations() {
        fetchReservationsUseCase.fetchReservations()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let reservations):
                    self?._reservations.accept(reservations)
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }
}

extension ReservationListViewModel: ReservationListViewModelOutputs {
    var outputs: ReservationListViewModelOutputs { return self }
    var reservations: Driver<[ReservationModel]> { _reservations.asDriver(onErrorJustReturn: []) }
}
