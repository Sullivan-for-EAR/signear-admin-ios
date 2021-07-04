//
//  HelloViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/11.
//

import UIKit
import RxCocoa
import RxSwift

class HelloViewController: UIViewController {
    
    // MARK : Properties - UI
    
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK : Properties - Private
    
    private let disposeBag = DisposeBag()
    private var viewModel: HelloViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK : Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = HelloViewModel()
    }
}

// MARK : Private

extension HelloViewController {
    
    private func configureUI() {
        configureBackgroundColor()
        startButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.showReservationListView()
            }).disposed(by: disposeBag)
    }
    
    private func configureBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(r: 10, g: 132, b: 255).cgColor,
                                UIColor.init(r: 0, g: 178, b: 255).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func bindUI() {
    }
    
    private func showReservationListView() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchRootViewToReservationListView()
    }
}
