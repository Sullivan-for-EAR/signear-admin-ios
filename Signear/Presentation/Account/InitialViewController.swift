//
//  InitialViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/05.
//

import UIKit
import RxCocoa
import RxSwift

class InitialViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        configuareUI()
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

// MARK: Private

extension InitialViewController {
    
    private func configuareUI() {
        configuareBackgroundLayer()
        startButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.showEmailCheckView()
            }).disposed(by: disposeBag)
    }
    
    private func configuareBackgroundLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(r: 10, g: 132, b: 255).cgColor,
                                UIColor.init(r: 0, g: 178, b: 255).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func showEmailCheckView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EmailCheckViewController") as? EmailCheckViewController else { return }
        navigationController?.pushViewController(vc, animated: false)
    }
}
