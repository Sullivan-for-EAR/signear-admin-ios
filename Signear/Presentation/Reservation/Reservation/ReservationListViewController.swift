//
//  ReservationListViewController.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import UIKit
import RxCocoa
import RxSwift

class ReservationListViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties - Private
    
    private let tableViewBackgroundView =  Bundle.main.loadNibNamed("ReservationListBackgroundView", owner: nil, options: nil)?.first as! UIView
    private let disposeBag = DisposeBag()
    private var viewModel: ReservationListViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = ReservationListViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.inputs.fetchReservations()
    }
}

// MARK: - Private

extension ReservationListViewController {
    
    private func configureUI() {
        historyButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.showHistoryView()
            }).disposed(by: disposeBag)
        
        tableView.register(.init(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "ReservationTableViewCell")
        tableView.rx.modelSelected(ReservationModel.self)
            .asDriver()
            .drive(onNext: { [weak self] reservation in
                self?.showReservationInfoView(reservation: reservation)
            }).disposed(by: disposeBag)
    }
    
    private func bindUI() {
        viewModel?.outputs.reservations
            .do(onNext: { [weak self] reservations in
                guard let self = self else { return }
                self.tableView.backgroundView = reservations.count > 0 ? nil : self.tableViewBackgroundView
            })
            .drive(tableView.rx.items(cellIdentifier: "ReservationTableViewCell", cellType: ReservationTableViewCell.self)) ({ index, reservation, cell in
                cell.setReservation(reservation)
            }).disposed(by: disposeBag)
    }
    
    private func showReservationInfoView(reservation: ReservationModel) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ReservationInfoViewController") as? ReservationInfoViewController else { return }
        vc.reservationId = reservation.rsID
        vc.viewType = .reservation
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showHistoryView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ReservationHistoryViewController") as? ReservationHistoryViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
