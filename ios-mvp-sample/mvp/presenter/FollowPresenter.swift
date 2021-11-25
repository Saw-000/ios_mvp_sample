//
//  FollowPresenter.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol FollowPresenterInput {
    func viewDidAppear()
}
protocol FollowPresenterOutput: AnyObject {
    func setNavigationBarTitle(title: String?)
}


class FollowPresenter {
    // view
    private weak var view: FollowPresenterOutput!
    
    // model
    private var model: FollowModelInput
    
    init(view: FollowPresenterOutput, model: FollowModelInput) {
        self.view = view
        self.model = model
    }
    
}

extension FollowPresenter: FollowPresenterInput {
    func viewDidAppear() {
        view.setNavigationBarTitle(title: "フォロー")
    }
}
