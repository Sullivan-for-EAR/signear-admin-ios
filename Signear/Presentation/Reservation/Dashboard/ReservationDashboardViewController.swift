//
//  ReservationDashboardViewController.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import UIKit

class ReservationDashboardViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties - Private
    
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
}

// MARK: - Private

extension ReservationDashboardViewController {
    
    private func configureUI() {
        configureCollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "DashboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCollectionViewCell")
    }
    
    private func bindUI() {
        
    }
    
    private func configureCollectionViewFlowLayout() {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

extension ReservationDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 44, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as? DashboardCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .brown
        return cell
    }
}


