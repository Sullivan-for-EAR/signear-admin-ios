//
//  ProfileTableViewCell.swift
//  signear
//
//  Created by 신정섭 on 2021/05/25.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    
}

// MARK: - Internal

extension ProfileTableViewCell {
    func setProfile(_ profile: ProfileModel) {
        nameLabel.text = profile.name
        phoneNumberLabel.text = profile.phoneNumber
    }
}
