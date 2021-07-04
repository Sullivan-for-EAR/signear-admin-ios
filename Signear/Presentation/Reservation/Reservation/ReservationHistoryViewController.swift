//
//  ReservationHistoryViewController.swift
//  Signear
//
//  Created by 신정섭 on 2021/07/04.
//

import UIKit
import RxCocoa
import RxSwift

class ReservationHistoryViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties - Private
    
    private let disposeBag = DisposeBag()
    private var viewModel: ReservationHistoryViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = ReservationHistoryViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        viewModel?.inputs.fetchReservationHistory()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    
    @objc private func didTappedBackButton(_ button: UINavigationItem) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private

extension ReservationHistoryViewController {
    
    private func configureUI() {
        title = "지난 예약"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = .init()
        navigationItem.leftBarButtonItem = .init(image: .init(named: "leftArrowIcon"), style: .plain, target: self, action: #selector(didTappedBackButton(_:)))
        
        tableView.register(.init(nibName: "ReservationHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ReservationHistoryTableViewCell")
        tableView.rx.modelSelected(ReservationHistoryModel.self)
            .asDriver()
            .drive(onNext: { [weak self] history in
                self?.showReservationInfoView(history: history)
            }).disposed(by: disposeBag)
    }
    
    private func bindUI() {
        viewModel?.outputs.reservationHistory
            .drive(tableView.rx.items(cellIdentifier: "ReservationHistoryTableViewCell", cellType: ReservationHistoryTableViewCell.self)) ({ index, history, cell in
                cell.setHistory(history)
            }).disposed(by: disposeBag)
    }
    
    private func showReservationInfoView(history: ReservationHistoryModel) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ReservationInfoViewController") as? ReservationInfoViewController else { return }
        vc.reservationId = history.rsID
        vc.viewType = .history
        navigationController?.pushViewController(vc, animated: true)
    }
}
