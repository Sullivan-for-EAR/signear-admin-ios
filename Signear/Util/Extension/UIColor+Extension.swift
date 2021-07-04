//
//  UIColor+Extension.swift
//  signear
//
//  Created by 신정섭 on 2021/05/05.
//

import UIKit

extension UIColor {
    
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    public convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            r: (rgb >> 16) & 0xFF,
            g: (rgb >> 8) & 0xFF,
            b: rgb & 0xFF,
            alpha: alpha
        )
    }
}
