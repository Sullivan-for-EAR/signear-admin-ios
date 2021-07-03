//
//  SignUpViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/09.
//

import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {
    
    // MARK: - Properties - UI
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var areaTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - Properties - Internal
    
    var email: String!
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var viewModel: SignUpViewModelType? {
        didSet {
            bindUI()
        }
    }
    private let areaPickerView = UIPickerView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = SignUpViewModel()
        viewModel?.inputs.fetchArea()
    }
    
    // MARK: - Actions
    
    @objc private func didAreaPickerViewDoneButtonPressed() {
        view.endEditing(true)
    }
}

// MARK : Private

extension SignUpViewController {
    
    private func configureUI() {
        configureAreaPickerView()
        emailTextField.text = email
        initBackgroundColor()
        
        signUpButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let email = self.emailTextField.text,
                      let password = self.passwordTextField.text,
                      let address = self.areaTextField.text else {
                    return
                }
                self.viewModel?.inputs.signUp(email: email, password: password, address: address)
            }).disposed(by: disposeBag)
    }
    
    private func configureAreaPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButon = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didAreaPickerViewDoneButtonPressed))
        toolbar.setItems([doneButon], animated: true)
        
        areaTextField.inputView = areaPickerView
        areaTextField.inputAccessoryView = toolbar
        areaPickerView.rx.modelSelected(String.self)
            .asDriver()
            .drive(onNext: { [weak self] area in
                guard let self = self else {
                    return
                }
                self.areaTextField.text = area[0]
            }).disposed(by: disposeBag)
    }
    
    private func initBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(r: 10, g: 132, b: 255).cgColor,
                                UIColor.init(r: 0, g: 178, b: 255).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func bindUI() {
        viewModel?.outputs.area
            .drive(areaPickerView.rx.itemTitles) ({ index, area in
                return area
            }).disposed(by: disposeBag)
        
        viewModel?.outputs.signUpResult
            .filter { $0 }
            .drive(onNext: { [weak self] result in
                self?.showHelloViewController()
            }).disposed(by: disposeBag)
    }
    
    private func showHelloViewController() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HelloViewController") as? HelloViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
