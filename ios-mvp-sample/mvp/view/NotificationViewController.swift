//
//  NotificationViewController.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class NotificationViewController: UIViewController {

    // 型付きself.view
    private var rootView: NotificationRootView { self.view as! NotificationRootView }
    // プレセンター
    private var presenter: NotificationPresenterInput!
    
    override func loadView() {
        view = NotificationRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotificationPresenter(view: self, model: NotificationModel())
        rootView.notificationListTableView.delegate = self
        rootView.notificationListTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
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
        typealias cellclass = NotificationTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellclass.identifier, for: indexPath) as? cellclass else {
            return UITableViewCell()
        }
        
        guard let cellInfo = presenter.getNotificationCellInfo(at: indexPath.row) else {
            return cell
        }
        cell.dateLabel.text = cellInfo.dateStr
        cell.bodyTextLabel.text = cellInfo.text
        
        return cell
    }
    
    // タップ時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NotificationViewController: NotificationPresenterOutput {
    
    func setNavigationBarTitle(title: String?) {
        setNavigationBarTitle(title)
    }
    
    func reloadTableView() {
        rootView.notificationListTableView.reloadData()
    }
}
