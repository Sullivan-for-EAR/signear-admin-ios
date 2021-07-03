//
//  Encodable+Extension.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/03.
//

import Foundation

extension Encodable {
    
    var toDictionary : [String: Any] {
        guard let object = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String : Any] else { return [:] }
        return dictionary
    }
}
