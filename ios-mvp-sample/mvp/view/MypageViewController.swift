//
//  MypageViewController.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class MypageViewController: UIViewController {

    // 型付きself.view
    private var rootView: MypageRootView { self.view as! MypageRootView }
    // プレセンター
    private var presenter: MypagePresenterInput!
    
    override func loadView() {
        view = MypageRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.commentListTableView.delegate = self
        rootView.commentListTableView.dataSource = self
        presenter = MypagePresenter(view: self, model: MypageModel())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

}

extension MypageViewController: UITableViewDelegate, UITableViewDataSource {
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

extension MypageViewController: MypagePresenterOutput {
    
    func setNavigationBarTitle(title: String?) {
        setNavigationBarTitle(title)
    }
    
    func reloadTableView() {
        rootView.commentListTableView.reloadData()
    }
    
    func presentAlert(info: AlertInfo) {
        presentAlert(info)
    }
}
