//
//  HomeRootView.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit
import MapKit


class HomeRootView: XibOwnerView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var addCommentButton: UIButton!
    
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
        typealias cellClass = CommentTableViewCell
        tableView.register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
    }
}
