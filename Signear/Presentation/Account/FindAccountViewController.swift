//
//  FindAccountViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import UIKit

class FindAccountViewController: UIViewController {
    
    // MARK : UI
    
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK : Life Cycle
    
    override func viewDidLoad() {
        initUI()
    }
}

// MARK : Private

extension FindAccountViewController {
    
    private func initUI() {
        initBackgroundColor()
    }
    
    private func initBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(r: 10, g: 132, b: 255).cgColor,
                                UIColor.init(r: 0, g: 178, b: 255).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func bindUI() {
        
    }
}
