//
//  ProfileModel.swift
//  signear
//
//  Created by 신정섭 on 2021/05/26.
//

import Foundation

struct ProfileModel: Equatable {
    let name: String
    let phoneNumber: String
    
    init() {
        self.init(name: "", phoneNumber: "")
    }
    
    init(name: String,
         phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
    }
}
