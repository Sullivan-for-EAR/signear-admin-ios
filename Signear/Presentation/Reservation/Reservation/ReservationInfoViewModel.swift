//
//  ReservationInfoViewModel.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation
import RxCocoa
import RxSwift

protocol ReservationInfoViewModelInputs {
    func fetchReservationInfo(reservationId: Int)
}

protocol ReservationInfoViewModelOutputs {
    var reservationInfo: Driver<ReservationInfoModel?> { get }
}

protocol ReservationInfoViewModelType {
    var inputs: ReservationInfoViewModelInputs { get }
    var outputs: ReservationInfoViewModelOutputs { get }
}

class ReservationInfoViewModel: ReservationInfoViewModelType {
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private let _reservationInfo: PublishRelay<ReservationInfoModel?> = .init()
    private let fetchReservationInfoUseCase: FetchReservationInfoUseCaseType
    
    // MARK: - Life Cycle
    
    init(fetchReservationInfoUseCase: FetchReservationInfoUseCaseType) {
        self.fetchReservationInfoUseCase = fetchReservationInfoUseCase
    }
    
    convenience init() {
        self.init(fetchReservationInfoUseCase: FetchReservationInfoUseCase())
    }
}

extension ReservationInfoViewModel: ReservationInfoViewModelInputs {
    
    var inputs: ReservationInfoViewModelInputs { return self }
    
    func fetchReservationInfo(reservationId: Int) {
        fetchReservationInfoUseCase.fetchReservationInfo(reservationId: reservationId)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let reservationInfo):
                    self?._reservationInfo.accept(reservationInfo)
                case .failure(_):
                    // TODO : API Error
                    break
                }
            }).disposed(by: disposeBag)
    }
}

extension ReservationInfoViewModel: ReservationInfoViewModelOutputs {
    
    var outputs: ReservationInfoViewModelOutputs { return self }
    var reservationInfo: Driver<ReservationInfoModel?> { _reservationInfo.asDriver(onErrorJustReturn: nil) }
}
