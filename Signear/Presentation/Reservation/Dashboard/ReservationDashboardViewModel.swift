//
//  ReservationDashboardViewModel.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import Foundation

protocol ReservationDashboardViewModelInputs {
    func fetchDashboard()
}

protocol ReservationDashboardViewModelOutputs {
}

protocol ReservationDashboardViewModelType {
    var inputs: ReservationDashboardViewModelInputs { get }
    var outputs: ReservationDashboardViewModelOutputs { get }
}

class ReservationDashboardViewModel: ReservationDashboardViewModelType {
    
    // MARK: - Properties - Private
    
    private let useCase: FetchDashboardUseCaseType
    
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
    }
}

extension ReservationDashboardViewModel: ReservationDashboardViewModelOutputs {
    var outputs: ReservationDashboardViewModelOutputs { return self }
    
}
