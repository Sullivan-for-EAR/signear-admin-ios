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
    func fetchReservationInfo(reservationId: Int)
    func accept(reservationId: Int)
    func reject(reservationId: Int, message: String?)
}

protocol DashboardInfoViewModelOutputs {
    var reservationInfo: Driver<ReservationInfoModel?> { get }
    var acceptResult: Driver<Bool> { get }
    var rejectResult: Driver<Bool> { get }
}

protocol DashboardInfoViewModelType {
    var inputs: DashboardInfoViewModelInputs { get }
    var outputs: DashboardInfoViewModelOutputs { get }
}

class DashboardInfoViewModel: DashboardInfoViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let fetchReservationInfoUseCase: FetchReservationInfoUseCaseType
    private let acceptReservationUseCase: AcceptReservationUseCaseType
    private let rejectReservationUseCase: RejectReservationUseCaseType
    private var _reservationInfo: PublishRelay<ReservationInfoModel?> = .init()
    private var _acceptResult: PublishRelay<Bool> = .init()
    private var _rejectResult: PublishRelay<Bool> = .init()
    
    // MARK: - Life Cycle
    
    init(fetchReservationInfoUseCase: FetchReservationInfoUseCaseType,
         acceptReservationUseCase: AcceptReservationUseCaseType,
         rejectReservationUseCase: RejectReservationUseCaseType) {
        self.fetchReservationInfoUseCase = fetchReservationInfoUseCase
        self.acceptReservationUseCase = acceptReservationUseCase
        self.rejectReservationUseCase = rejectReservationUseCase
    }
    
    convenience init() {
        self.init(fetchReservationInfoUseCase: FetchReservationInfoUseCase(),
                  acceptReservationUseCase: AcceptReservationUseCase(),
                  rejectReservationUseCase: RejectReservationUseCase())
    }
}

// MARK: - DashboardInfoViewModelInputs

extension DashboardInfoViewModel: DashboardInfoViewModelInputs {
    
    var inputs: DashboardInfoViewModelInputs { return self }
    
    func fetchReservationInfo(reservationId: Int) {
        fetchReservationInfoUseCase.fetchReservationInfo(reservationId: reservationId)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let reservation):
                    self?._reservationInfo.accept(reservation)
                    break
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    func reject(reservationId: Int, message: String?) {
        rejectReservationUseCase.reject(reservationId: reservationId, reject: message)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(_):
                    self?._rejectResult.accept(true)
                    break
                case .failure(_):
                    break
                }
                
            }).disposed(by: disposeBag)
    }
    
    func accept(reservationId: Int) {
        acceptReservationUseCase.accept(reservationId: reservationId)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(_):
                    self?._acceptResult.accept(true)
                    break
                case .failure(_):
                    break
                }
                
            }).disposed(by: disposeBag)
    }
}

// MARK: - DashboardInfoViewModelOutputs

extension DashboardInfoViewModel: DashboardInfoViewModelOutputs {
    
    var outputs: DashboardInfoViewModelOutputs { return self }
    var reservationInfo: Driver<ReservationInfoModel?> { _reservationInfo.asDriver(onErrorJustReturn: nil) }
    var acceptResult: Driver<Bool> { _acceptResult.asDriver(onErrorJustReturn: false) }
    var rejectResult: Driver<Bool> { _rejectResult.asDriver(onErrorJustReturn: false) }
}
