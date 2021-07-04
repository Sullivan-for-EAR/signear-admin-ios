//
//  ReservationDashboardViewModel.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import Foundation
import RxCocoa
import RxSwift

protocol ReservationDashboardViewModelInputs {
    func fetchDashboard()
}

protocol ReservationDashboardViewModelOutputs {
    var dashboard: Driver<[ReservationModel]> { get }
}

protocol ReservationDashboardViewModelType {
    var inputs: ReservationDashboardViewModelInputs { get }
    var outputs: ReservationDashboardViewModelOutputs { get }
}

class ReservationDashboardViewModel: ReservationDashboardViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let useCase: FetchDashboardUseCaseType
    private var _dashboard: BehaviorRelay<[ReservationModel]> = .init(value: [])
    
    // MARK: - Properties - Life Cycle
    
    init(useCase: FetchDashboardUseCaseType) {
        self.useCase = useCase
    }
    
    convenience init() {
        self.init(useCase: FetchDashboardUseCase())
    }
}

extension ReservationDashboardViewModel: ReservationDashboardViewModelInputs {
    var inputs: ReservationDashboardViewModelInputs { return self }
    
    func fetchDashboard() {
        useCase.fetchDashboard()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let dashboard):
                    self?._dashboard.accept(dashboard)
                case .failure(_):
                    // TODO : error
                    break
                }
            }).disposed(by: disposeBag)
    }
}

extension ReservationDashboardViewModel: ReservationDashboardViewModelOutputs {
    var outputs: ReservationDashboardViewModelOutputs { return self }
    var dashboard: Driver<[ReservationModel]> { _dashboard.asDriver(onErrorJustReturn: []) }
}
