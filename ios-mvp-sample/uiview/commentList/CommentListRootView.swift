//
//  CommentListRootView.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit
import MapKit

class CommentListRootView: XibOwnerView {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var commentListPullUpButton: UIButton!
    @IBOutlet weak var addNewListButton: UIButton!
    
    @IBOutlet weak var listCommentsTableView: UITableView!
    
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
        listCommentsTableView.register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
    }
}
