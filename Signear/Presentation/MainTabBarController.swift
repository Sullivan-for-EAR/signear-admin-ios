//
//  MainTabBarController.swift
//  Signear
//
//  Created by 신정섭 on 2021/06/03.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties - Private
    
    private enum Constants {
        static let defaultSelectedIndex = 1
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = Constants.defaultSelectedIndex
    }
}

// MARK: - Private

extension MainTabBarController {
    
    private func configureTabBar() {
        delegate = self
        let dashboardVC = getReservationDashboardViewController()
        dashboardVC.tabBarItem = UITabBarItem(title: "실시간 예약", image: .init(named: "dashboardDeselectIcon"), selectedImage: .init(named: "dashboardSelectIcon"))
        let listVC = getReservationViewController()
        listVC.tabBarItem = UITabBarItem(title: "예약 관리", image: .init(named: "listDeselectIcon"), selectedImage: .init(named: "listSelectIcon"))
        let myPageVC = getMyPageViewController()
        myPageVC.tabBarItem = UITabBarItem(title: "프로필", image: .init(named: "myPageDeselectIcon"), selectedImage: .init(named: "myPageSelectIcon"))
        
        viewControllers = [dashboardVC, listVC, myPageVC]
    }
    
    private func getReservationDashboardViewController() -> ReservationDashboardViewController {
        let storyboard = UIStoryboard(name: "Reservation", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ReservationDashboardViewController") as? ReservationDashboardViewController else {
            return ReservationDashboardViewController()
        }
        return vc
    }
    
    private func getReservationViewController() -> ReservationListViewController {
        let storyboard = UIStoryboard(name: "Reservation", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ReservationListViewController") as? ReservationListViewController else {
            return ReservationListViewController()
        }
        return vc
    }
    
    private func getMyPageViewController() -> MyPageViewController {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {
            return MyPageViewController()
        }
        return vc
    }
}


// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
