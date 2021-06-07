//
//  DashboardInfoViewModel.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/07.
//

import Foundation
import RxCocoa
import RxSwift

protocol DashboardInfoViewModelInputs {
    func fetchReservationInfo()
}

protocol DashboardInfoViewModelOutputs {
    var reservation: Driver<ReservationInfoModel> { get }
}

protocol DashboardInfoViewModelType {
    var inputs: DashboardInfoViewModelInputs { get }
    var outputs: DashboardInfoViewModelOutputs { get }
}

class DashboardInfoViewModel: DashboardInfoViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let useCase: FetchReservationInfoUseCaseType
    private let _reservation: PublishRelay<ReservationInfoModel> = .init()
    
    // MARK: - Life Cycle
    
    init(useCase: FetchReservationInfoUseCaseType) {
        self.useCase = useCase
    }
    
    convenience init() {
        self.init(useCase : FetchReservationInfoUseCase())
    }
}

// MARK: - DashboardInfoViewModelInputs

extension DashboardInfoViewModel: DashboardInfoViewModelInputs {
    var inputs: DashboardInfoViewModelInputs { return self }
    func fetchReservationInfo() {
        useCase.fetchReservationInfo()
            .bind(to: _reservation)
            .disposed(by: disposeBag)
    }
}

// MARK: - DashboardInfoViewModelOutputs

extension DashboardInfoViewModel: DashboardInfoViewModelOutputs {
    var outputs: DashboardInfoViewModelOutputs { return self }
    var reservation: Driver<ReservationInfoModel> { _reservation.asDriver(onErrorJustReturn: .init()) }
}
