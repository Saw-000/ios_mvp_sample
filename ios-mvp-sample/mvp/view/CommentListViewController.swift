//
//  CommentListViewController.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class CommentListViewController: UIViewController {

    // 型付きself.view
    private var rootView: CommentListRootView { self.view as! CommentListRootView }
    // プレセンター
    private var presenter: CommentListPresenterInput!
    
    override func loadView() {
        view = CommentListRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CommentListPresenter(view: self, model: CommentListModel())
        rootView.listCommentsTableView.delegate = self
        rootView.listCommentsTableView.dataSource = self
        setEvent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func setEvent() {
        rootView.addNewListButton.addTarget(
            self, action: #selector(onAddNewListButtonButton), for: .touchUpInside)
    }
    @objc private func onAddNewListButtonButton(_ b: UIButton) {
        presenter.dispatchViewEvent(.ADD_NEW_LIST_BUTTON)
    }
}

extension CommentListViewController: UITableViewDelegate, UITableViewDataSource {
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
        presenter.dispatchViewEvent(.COMMENT_CELL_SELECTED(indexPath))
    }
    
}

extension CommentListViewController: CommentListPresenterOutput {
    
    func setNavigationBarTitle(title: String?) {
        setNavigationBarTitle(title)
    }
    
    func reloadTableView() {
        rootView.listCommentsTableView.reloadData()
    }
    
    func presentAddCommentListDialog(
        completion: @escaping (AddCommentListDialogCallbackInfo?) -> Void
    ) {
        let dialog = AddCommentListDialog()
        // コールバック設定
        dialog.completion = { info in
            dialog.removeFromSuperViewWithAnimation(
                duration: 0.25,
                options: .transitionCrossDissolve) { _ in
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
            options: .transitionCrossDissolve)
    }
    
    func presentAlert(info: AlertInfo) {
        presentAlert(info)
    }
}
