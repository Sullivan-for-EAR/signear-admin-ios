//
//  MyPageViewController.swift
//  signear
//
//  Created by 신정섭 on 2021/05/25.
//

import UIKit
import MessageUI
import RxCocoa
import RxSwift

class MyPageViewController: UIViewController {
    
    // MARK: - Properties - UI
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties - Private
    
    private enum Constants {
        static let commentRow = 0
        static let logoutRow = 1
    }
    
    private var viewModel: MyPageViewModelType? {
        didSet {
            bindUI()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyPageViewModel()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.inputs.fetchProfile()
    }
}

// MARK: - Private

extension MyPageViewController {
    
    private func configureUI() {
        tableView.register(.init(nibName: "MyPageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageTableViewCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindUI() {
        viewModel?.outputs.profile
            .drive(onNext: { [weak self] profile in
                guard let self = self else { return }
                self.nameLabel.text = profile.name
                self.areaLabel.text = "\(profile.address)수어통역센터"
            }).disposed(by: disposeBag)
    }
    
    private func showCommentPage() {
        if MFMailComposeViewController.canSendMail() {
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            
            compseVC.setToRecipients(["sullivan_developer@signear.com"])
            compseVC.setSubject("의견 보내기")
            
            self.present(compseVC, animated: true, completion: nil)
        }
        else {
            self.showSendMailErrorAlert()
        }
    }
    
    private func showLogoutAlertView() {
        let alert = UIAlertController(title: "로그아웃",
                                      message: "정말 로그아웃 하시나요?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { [weak self] _ in
            self?.logout()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func logout() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchRootViewToInitialView()
    }
    
    private func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case Constants.commentRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return MyPageTableViewCell() }
            cell.setTitle(NSLocalizedString("의견 남기기", comment: ""))
            return cell
        case Constants.logoutRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return MyPageTableViewCell() }
            cell.setTitle(NSLocalizedString("로그아웃", comment: ""))
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return MyPageTableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case Constants.commentRow:
            showCommentPage()
        case Constants.logoutRow:
            showLogoutAlertView()
        default:
            return
        }
    }
}

extension MyPageViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
