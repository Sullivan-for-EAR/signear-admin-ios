//
//  MyPageTableViewCell.swift
//  signear
//
//  Created by 신정섭 on 2021/05/25.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var titleLabel: UILabel!
    
}

// MARK: Internal

extension MyPageTableViewCell {
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
