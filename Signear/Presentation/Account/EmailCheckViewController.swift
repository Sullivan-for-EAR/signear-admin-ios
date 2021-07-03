//
//  EmailCheckViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/05.
//

import UIKit
import RxCocoa
import RxSwift

class EmailCheckViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var findAccountLabel: UILabel!
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var viewModel: EmailCheckViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuareUI()
        viewModel = EmailCheckViewModel()
        
        #if DEBUG
        emailTextField.text = "test@ab.cd"
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Private

extension EmailCheckViewController {
    
    private func configuareUI() {
        configuareBackgroundLayer()
        
        nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let email = self.emailTextField.text else {
                    return
                }
                self.viewModel?.inputs.checkEmail(email)
            }).disposed(by: disposeBag)
    }
    
    private func configuareBackgroundLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(r: 10, g: 132, b: 255).cgColor,
                                UIColor.init(r: 0, g: 178, b: 255).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func bindUI() {
        viewModel?.outputs.checkEmailResult
            .drive(onNext: { [weak self] existAccount in
                if existAccount {
                    self?.showLoginViewController()
                } else {
                    self?.showSignUpViewController()
                }
            }).disposed(by: disposeBag)
    }
    
    private func showLoginViewController() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        vc.email = emailTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSignUpViewController() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        vc.email = emailTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
}
