//
//  FetchDashboardDTO.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

enum FetchDashboardDTO {
    
    struct Request: Codable {
        let reservationId: Int
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
        }
    }
    
    struct Response: Decodable {
        let rsID: Int
        let date: String
        let startTime: String?
        let endTime: String?
        let area: String?
        let address: String?
        let method: Int
        let status: Int
        let type: Int
        let request: String?
        let reject: String?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.rsID = try container.decode(Int.self, forKey: .rsID)
            self.date = try container.decode(String.self, forKey: .date)
            self.startTime = try? container.decode(String.self, forKey: .startTime)
            self.endTime = try? container.decode(String.self, forKey: .endTime)
            self.area = try? container.decode(String.self, forKey: .area)
            self.address = try? container.decode(String.self, forKey: .address)
            self.method = try container.decode(Int?.self, forKey: .method) ?? 0
            self.status = try container.decode(Int.self, forKey: .status)
            self.type = try container.decode(Int.self, forKey: .type)
            self.request = try? container.decode(String.self, forKey: .request)
            self.reject = try? container.decode(String.self, forKey: .reject)
        }
        
        private enum CodingKeys: String, CodingKey {
            case rsID
            case date
            case startTime = "start_time"
            case endTime = "end_time"
            case area
            case address
            case method
            case status
            case type
            case request
            case reject
        }
    }
}

extension FetchDashboardDTO.Response {
    func toDomain() -> ReservationModel {
        return .init(rsID: rsID,
                     date: date,
                     startTime: startTime ?? "",
                     endTime: endTime ?? "",
                     area: area,
                     address: address,
                     method: .init(rawValue: method) ?? ReservationModel.MeetingType.error,
                     status: .init(rawValue: status) ?? ReservationModel.Status.error,
                     type: .init(rawValue: type) ?? ReservationModel.CallType.error,
                     request: request,
                     reject: reject)
    }
    
    func toDomain() -> ReservationInfoModel {
        return .init(rsID: rsID,
                     date: date,
                     startTime: startTime ?? "",
                     endTime: endTime ?? "",
                     area: area,
                     address: address,
                     method: .init(rawValue: method) ?? ReservationInfoModel.MeetingType.error,
                     status: .init(rawValue: status) ?? ReservationInfoModel.Status.error,
                     type: .init(rawValue: type) ?? ReservationInfoModel.CallType.error,
                     request: request,
                     reject: reject)
    }
}
