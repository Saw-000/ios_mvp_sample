//
//  HomeViewController.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class HomeViewController: UIViewController {
    // 型付きself.view
    private var rootView: HomeRootView { self.view as! HomeRootView }
    // プレセンター
    private var presenter: HomePresenterInput!
    
    override func loadView() {
        view = HomeRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self, model: HomeModel())
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        setEvent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func setEvent() {
        rootView.addCommentButton.addTarget(
            self, action: #selector(onAddCommentButton), for: .touchUpInside)
    }
    
    @objc private func onAddCommentButton(_ b: UIButton) {
        presenter.didTapAddCommentButton()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    // セクションにおけるセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableView(numberOfRowsInSection: section)
    }
    
    // セル作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        typealias cellclass = CommentTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellclass.identifier, for: indexPath) as? cellclass else {
            return UITableViewCell()
        }
        
        guard let cellInfo = presenter.getCommentCellInfo(at: indexPath.row) else {
            return cell
        }
        cell.bodyTextLabel.text = cellInfo.text
        cell.userNameLabel.text = cellInfo.userName
        
        return cell
    }
    
    // タップ時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HomeViewController: HomePresenterOutput {
    func setNavigationBarTitle(title: String?) {
        setNavigationBarTitle(title)
    }
    
    func reloadTableView() {
        rootView.tableView.reloadData()
    }
    
    func presentAddCommentDialog(completion: @escaping (AddCommentDialogCallbackInfo?) -> Void) {
        let dialog = AddCommentDialog()
        // コールバック設定
        dialog.completion = { info in
            dialog.removeFromSuperViewWithAnimation(
                duration: 0.25,
                options: .transitionFlipFromBottom) { _ in
                    completion(info)
                }
        }
        guard let window = UIApplication.getWindow() else {
            assert(false)
            return
        }
        // フルスクリーンで表示
        window.addFullScreenSubviewWithAnimation(
            v: dialog,
            duration: 0.25,
            options: .transitionFlipFromTop)
    }
    
    func presentAlert(info: AlertInfo) {
        presentAlert(info)
    }
}
