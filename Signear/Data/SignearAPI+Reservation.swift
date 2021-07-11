//
//  SignearAPI+Reservation.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation
import Alamofire
import RxSwift

extension SignearAPI {
    
    func fetchDashboard() -> Observable<Result<[FetchReservationInfoDTO.Response], APIError>> {
        let url = Constants.baseURL + Constants.fetchDashboardURL
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token,
                  let signId = self.signId else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .get,
                           parameters: FetchDashboardDTO.Request(signId: "\(signId)").toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: [FetchReservationInfoDTO.Response].self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onNext(.failure(.internalError(message: error.localizedDescription)))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchReservations() -> Observable<Result<[FetchReservationInfoDTO.Response], APIError>> {
        let url = Constants.baseURL + Constants.fetchReservationListURL
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token,
                  let signId = self.signId else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .get,
                           parameters: FetchReservationsDTO.Request(signId: signId).toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: [FetchReservationInfoDTO.Response].self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onNext(.failure(.internalError(message: error.localizedDescription)))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchReservationInfo(reservationId: Int) -> Observable<Result<FetchReservationInfoDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.fetchReservationInfoURL
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .get,
                           parameters: FetchReservationInfoDTO.Request(reservationId: reservationId).toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: FetchReservationInfoDTO.Response.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onNext(.failure(.internalError(message: error.localizedDescription)))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func acceptReservation(reservationId: Int) -> Observable<Result<AcceptReservationDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.acceptReservationURL.replacingOccurrences(of: "{reservationId}", with: "\(reservationId)")
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token,
                  let signId = self.signId else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .post,
                           parameters: AcceptReservationDTO.Request(signId: "\(signId)").toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: AcceptReservationDTO.Response.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onNext(.failure(.internalError(message: error.localizedDescription)))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func rejectReservation(reservationId: Int) -> Observable<Result<RejectReservationDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.fetchReservationInfoURL.replacingOccurrences(of: "{reservationId}", with: "\(reservationId)")
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token,
                  let signId = self.signId else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .post,
                           parameters: RejectReservationDTO.Request(signId: "\(signId)").toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: RejectReservationDTO.Response.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onNext(.failure(.internalError(message: error.localizedDescription)))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchReservationHistory() -> Observable<Result<[FetchReservationInfoDTO.Response], APIError>> {
        let url = Constants.baseURL + Constants.fetchReservationHistoryURL
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token,
                  let signId = self.signId else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .get,
                           parameters: FetchReservationHistoryDTO.Request(signId: "\(signId)").toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: [FetchReservationInfoDTO.Response].self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onNext(.failure(.internalError(message: error.localizedDescription)))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
