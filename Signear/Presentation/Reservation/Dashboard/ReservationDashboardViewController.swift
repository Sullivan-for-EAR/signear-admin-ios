//
//  ReservationDashboardViewController.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import UIKit
import RxCocoa
import RxSwift

class ReservationDashboardViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties - Private
    
    private let collectionViewBackgroundView =  Bundle.main.loadNibNamed("ReservationDashboardBackgroundView", owner: nil, options: nil)?.first as! UIView
    private let disposeBag = DisposeBag()
    private var viewModel: ReservationDashboardViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = ReservationDashboardViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.inputs.fetchDashboard()
    }
}

// MARK: - Private

extension ReservationDashboardViewController {
    
    private func configureUI() {
        configureCollectionViewFlowLayout()
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        collectionView.register(.init(nibName: "EmergencyDashboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmergencyDashboardCollectionViewCell")
        collectionView.register(.init(nibName: "DashboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCollectionViewCell")
    }
    
    private func bindUI() {
        viewModel?.outputs.dashboard
            .do(onNext: { [weak self] reservations in
                guard let self = self else { return }
                self.collectionView.backgroundView = reservations.count > 0 ? nil : self.collectionViewBackgroundView
            })
            .drive(collectionView.rx.items) ({ collectionView, index, reservation in
                switch reservation.type {
                case .emergency:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmergencyDashboardCollectionViewCell", for: .init(row: index, section: 0)) as! EmergencyDashboardCollectionViewCell
                    cell.delegate = self
                    return cell
                case .normal:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: .init(row: index, section: 0)) as! DashboardCollectionViewCell
                    cell.delegate = self
                    cell.updateUI(reservation: reservation)
                    return cell
                default:
                    return UICollectionViewCell()
                }
            }).disposed(by: disposeBag)
    }
    
    private func configureCollectionViewFlowLayout() {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func showEmergencyCall(reservationInfo: ReservationInfoModel) {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "영상전화 걸기", style: .default, handler: { [weak self] _ in
            self?.call()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func call() {
        // TODO : 영상 전화 처리 .?
    }
    
    private func showDashboardInfo(reservation: ReservationModel) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier:  "DashboardInfoViewController") as? DashboardInfoViewController else { return }
        vc.reservationId = reservation.rsID
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ReservationDashboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO : size 변경
        return .init(width: view.frame.width - 44, height: 260)
    }
}

extension ReservationDashboardViewController: DashboardCollectionViewCellDelegate {
    
    func didSelectMoreButton(_ dashboardCollectionViewCell: DashboardCollectionViewCell, _ reservation: ReservationModel) {
        showDashboardInfo(reservation: reservation)
    }
}

extension ReservationDashboardViewController: EmergencyDashboardCollectionViewCellDelegate {
    
    func didSelectAcceptButton(_ reservationInfo: ReservationInfoModel) {
        showEmergencyCall(reservationInfo: reservationInfo)
    }
}


