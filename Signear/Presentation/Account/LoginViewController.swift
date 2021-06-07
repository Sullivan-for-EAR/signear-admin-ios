//
//  LoginViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var findAccountLabel: UILabel!
    
    // MARK: - Properties - Internal
    
    var email: String!
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK : Life Cycle
    
    override func viewDidLoad() {
        configureUI()
        viewModel = LoginViewModel()
        
        #if DEBUG
        passwordTextField.text = "bfbfb"
        viewModel?.inputs.password.accept(passwordTextField.text)
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

// MARK : Private

extension LoginViewController {
    
    private func configureUI() {
        configuareBackgroundLayer()
        emailTextField.text = email
        
        let backImageViewTapGesture = UITapGestureRecognizer()
        backImageView.addGestureRecognizer(backImageViewTapGesture)
        backImageViewTapGesture.rx.event
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: false)
            }).disposed(by: disposeBag)
        
        nextButton.setBackgroundColor(.init(r: 34, g: 34, b: 34), for: .normal)
        nextButton.setBackgroundColor(.init(r: 182, g: 182, b: 182), for: .disabled)
        
        let findAccountLabelTapGesture = UITapGestureRecognizer()
        findAccountLabel.addGestureRecognizer(findAccountLabelTapGesture)
        findAccountLabelTapGesture.rx.event
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.showFindAccountView()
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
        guard let viewModel = viewModel else { return }
        emailTextField.rx.text
            .distinctUntilChanged()
            .bind(to: viewModel.inputs.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .distinctUntilChanged()
            .bind(to: viewModel.inputs.password)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(to: viewModel.inputs.login)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isValidAccountType
            .distinctUntilChanged()
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.outputs.loginResult
            .drive(onNext: { [weak self] isSucceed in
                if isSucceed {
                    self?.showReservationListView()
                }
            }).disposed(by: disposeBag)
    }
    
    private func showReservationListView() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchRootViewToReservationListView()
    }
    
    private func showFindAccountView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FindAccountViewController") as? FindAccountViewController else { return }
        navigationController?.pushViewController(vc, animated: false)
    }
}
