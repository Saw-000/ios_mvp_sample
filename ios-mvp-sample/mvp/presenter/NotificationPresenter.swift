//
//  NotificationPresenter.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol NotificationPresenterInput {
    func viewDidAppear()
    func getNotificationCellInfo(at index: Int) -> NotificationCellInfo?
    func numberOfSections() -> Int
    func tableView(numberOfRowsInSection: Int) -> Int
}
protocol NotificationPresenterOutput: AnyObject {
    func setNavigationBarTitle(title: String?)
    func reloadTableView()
}


class NotificationPresenter {
    
    // view
    private weak var view: NotificationPresenterOutput!
    
    // model
    private var model: NotificationModelInput
    
    init(view: NotificationPresenterOutput, model: NotificationModelInput) {
        self.view = view
        self.model = model
    }
    
}

extension NotificationPresenter: NotificationPresenterInput {
    func viewDidAppear() {
        view.setNavigationBarTitle(title: "通知")
        model.loadNotifications { success in
            switch success {
            case false:
                DispatchQueue.main.async {
                    // debug: 通知が取れなかったアラート表示
                    self.view.reloadTableView()
                }
            case true:
                DispatchQueue.main.async {
                    self.view.reloadTableView()
                }
            }
        }
    }
    
    func getNotificationCellInfo(at index: Int) -> NotificationCellInfo? {
        let notifications = model.getNotifications()
        guard 0 <= index, index < notifications.count else { return nil }
        let n = notifications[index]
        switch n.type {
        case .FOLLOWED:
            guard let info = n.contents.followedContent else { return nil }
            return NotificationCellInfo(
                dateStr: "[\(info.date)]",
                text: "\(info.followingUserId)さんからフォローされました！")
        case .LIST_FOLLOWED:
            return nil// debug: 実装
        case .REPLIED:
            return nil// debug: 実装
        }
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func tableView(numberOfRowsInSection: Int) -> Int {
        model.getNotifications().count
    }
}
