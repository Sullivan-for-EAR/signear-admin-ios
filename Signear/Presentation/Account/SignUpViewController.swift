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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @objc private func didAreaPickerViewDoneButtonPressed() {
        view.endEditing(true)
    }
}

// MARK : Private

extension SignUpViewController {
    
    private func configureUI() {
        configureBackgroundColor()
        configureBackImageView()
        configureAreaPickerView()
        
        emailTextField.text = email
        
        Observable.of(emailTextField.rx.text.orEmpty,
                      passwordTextField.rx.text.orEmpty,
                      areaTextField.rx.text.orEmpty).merge()
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] text in
                self?.updateUI()
            }).disposed(by: disposeBag)
    
        signUpButton.setBackgroundColor(.init(rgb: 0x222222), for: .normal)
        signUpButton.setBackgroundColor(.init(rgb: 0xB6B6B6), for: .disabled)
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
    
    private func configureBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(r: 10, g: 132, b: 255).cgColor,
                                UIColor.init(r: 0, g: 178, b: 255).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configureBackImageView() {
        let backGenture = UITapGestureRecognizer(target: self, action: nil)
        backGenture.rx.event
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: false)
            }).disposed(by: disposeBag)
        backImageView.addGestureRecognizer(backGenture)
    }
    
    private func configureAreaPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButon = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didAreaPickerViewDoneButtonPressed))
        toolbar.setItems([doneButon], animated: true)
        
        areaTextField.delegate = self
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
    
    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.signUpButton.isEnabled = self.emailTextField.text?.isValidEmail() == true && self.passwordTextField.text?.isNotEmpty == true &&
                self.areaTextField.text?.isNotEmpty == true
        }
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

extension SignUpViewController: UITextFieldDelegate {
    
    // TODO : 고쳐야하는 코드
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.isEmpty == true {
            areaTextField.text = "강남구"
        }
    }
}
