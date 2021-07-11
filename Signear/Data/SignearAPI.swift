//
//  SignearAPI.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/07.
//

import Foundation
import RxSwift
import Alamofire

enum APIError: Error {
    case internalError(message: String)
}

class SignearAPI {
    
    // MARK: - Properties - Static
    
    static let shared = SignearAPI()
    
    // MARK: - Properties - Internal
    
    enum Constants {
        static let baseURL = "http://49.50.166.181:8088"
        static let checkEmailURL = "/sign/check"
        static let signUpURL = "/user/sign/create"
        static let loginURL = "/sign/login"
        static let fetchDashboardURL = "/reservation/sign/list"
        static let fetchReservationInfoURL = "/reservation/sign/"
        static let fetchReservationListURL = "/reservation/sign/list"
        static let rejectReservationURL = "/reservation/sign/reject/{reservationId}"
        static let acceptReservationURL = "/reservation/sign/confirm/{reservationId}"
        static let fetchReservationHistoryURL = "/management/sign/list"
        static let getUserInfoURL = "/user/sign/"
    }
    
    // MARK: Properties - Private
    
    var token: String?
    var signId: Int?
    
    // MARK: - Constructor
    
    private init() { }
}

// MARK: - Internal

extension SignearAPI {
    func checkEmail(_ email: String) -> Observable<Result<CheckEmailDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.checkEmailURL
        return Observable.create { observer in
            let request =
                AF.request(url,
                           method: .get,
                           parameters: CheckEmailDTO.Request(email: email).toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: self.token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: CheckEmailDTO.Response.self) { response in
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
    
    func login(email: String, password: String) -> Observable<Result<LoginDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.loginURL
        return Observable.create { observer in
            let request =
                AF.request(url,
                           method: .post,
                           parameters: LoginDTO.Request(email: email, password: password).toDictionary,
                           encoding: JSONEncoding.default,
                           headers: .init(token: self.token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: LoginDTO.Response.self) { [weak self] response in
                    switch response.result {
                    case .success(let data):
                        self?.token = data.accessToken
                        self?.signId = data.userProfile.signID
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
    
    func signUp(email: String, password: String, address: String) -> Observable<Result<SignUpDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.signUpURL
        return Observable.create { observer in
            let request =
                AF.request(url,
                           method: .post,
                           parameters: SignUpDTO.Request(email: email,
                                                         password: password,
                                                         address: address).toDictionary,
                           encoding: JSONEncoding.default,
                           headers: .init(token: self.token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: SignUpDTO.Response.self) { [weak self] response in
                    switch response.result {
                    case .success(let data):
                        self?.token = data.accessToken
                        self?.signId = data.userProfile.signID
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
    
    func resetPassword(email: String) -> Observable<Result<Bool, APIError>> {
        let url = Constants.baseURL + Constants.loginURL
        return Observable.create { observer in
            let request =
                AF.request(url,
                           method: .post,
                           parameters: ResetPasswordDTO.Request(email: email).toDictionary,
                           encoding: JSONEncoding.default,
                           headers: .init(token: self.token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .response { response in
                    switch response.result {
                    case .success(_):
                        observer.onNext(.success(true))
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

func printServerMessage(data: Data?) {
    guard let data = data else {
        return
    }
    let serverMessage = String(decoding: data, as: UTF8.self)
    print(serverMessage)
}

extension HTTPHeaders {
    init(token: String?) {
        let accessToken = token ?? ""
        self.init(["access_token" : accessToken])
    }
}
