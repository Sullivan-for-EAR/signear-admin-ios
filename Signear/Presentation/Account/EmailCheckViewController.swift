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
        viewModel?.inputs.setEmail(emailTextField.text)
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
        
        let backImageViewTapGesture = UITapGestureRecognizer()
        backImageView.addGestureRecognizer(backImageViewTapGesture)
        backImageViewTapGesture.rx.event
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: false)
            }).disposed(by: disposeBag)
        
        emailTextField.rx.text
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] email in
                self?.viewModel?.inputs.setEmail(email)
            }).disposed(by: disposeBag)
        
    
        nextButton.setBackgroundColor(.init(r: 34, g: 34, b: 34), for: .normal)
        nextButton.setBackgroundColor(.init(r: 182, g: 182, b: 182), for: .disabled)
        nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel?.inputs.checkEmail()
            }).disposed(by: disposeBag)
        
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
        viewModel?.outputs.isValidEmailType
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel?.outputs.checkEmailResult
            .filter { $0 != nil }
            .map { $0! }
            .drive(onNext: { [weak self] email in
                self?.showLoginView(email: email)
            }).disposed(by: disposeBag)
    }
    
    private func showFindAccountView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FindAccountViewController") as? FindAccountViewController else { return }
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showLoginView(email: String) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        vc.email = email
        navigationController?.pushViewController(vc, animated: false)
    }
}
