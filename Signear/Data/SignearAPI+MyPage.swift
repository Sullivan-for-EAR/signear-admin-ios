//
//  SignearAPI+MyPage.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import Foundation
import Alamofire
import RxSwift

extension SignearAPI {
    
    func getUserInfo() -> Observable<Result<UserInfoDTO.Response, APIError>> {
        let url = Constants.baseURL + Constants.getUserInfoURL
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let token = self.token,
                  let signId = self.signId else {
                return Disposables.create()
            }
            let request =
                AF.request(url,
                           method: .get,
                           parameters: UserInfoDTO.Request(signId: "\(signId)").toDictionary,
                           encoding: URLEncoding.queryString,
                           headers: .init(token: token))
                .responseString { response in
                    printServerMessage(data: response.data)
                }
                .responseDecodable(of: UserInfoDTO.Response.self) { response in
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
