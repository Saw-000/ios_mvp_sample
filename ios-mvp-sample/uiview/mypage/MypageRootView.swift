//
//  MypageRootView.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class MypageRootView: XibOwnerView {
    @IBOutlet weak var commentListTableView: UITableView!
    
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
        commentListTableView.register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
    }
}
