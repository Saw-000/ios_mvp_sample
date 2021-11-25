//
//  FollowViewController.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

class FollowViewController: UIViewController {

    // 型付きself.view
    private var rootView: FollowRootView { self.view as! FollowRootView }
    // プレセンター
    private var presenter: FollowPresenterInput!
    
    override func loadView() {
        view = FollowRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FollowPresenter(view: self, model: FollowModel())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

}

extension FollowViewController: FollowPresenterOutput {
    func setNavigationBarTitle(title: String?) {
        setNavigationBarTitle(title)
    }
}
