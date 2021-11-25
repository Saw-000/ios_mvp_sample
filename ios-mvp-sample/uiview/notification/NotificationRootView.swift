//
//  NotificationRootView.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class NotificationRootView: XibOwnerView {
    @IBOutlet weak var notificationListTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        // tableViewに表示するセルを登録する
        typealias cellClass = NotificationTableViewCell
        notificationListTableView.register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
    }
}
