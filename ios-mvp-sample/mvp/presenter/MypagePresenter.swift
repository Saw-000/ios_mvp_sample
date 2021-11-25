//
//  MypagePresenter.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol MypagePresenterInput {
    func viewDidAppear()
    func getCommentCellInfo(at index: Int) -> CommentCellInfo?
    func numberOfSections() -> Int
    func tableView(numberOfRowsInSection: Int) -> Int
}
protocol MypagePresenterOutput: AnyObject {
    func setNavigationBarTitle(title: String?)
    func reloadTableView()
    func presentAlert(info: AlertInfo)
}


class MypagePresenter {
    // view
    private weak var view: MypagePresenterOutput!
    
    // model
    private var model: MypageModelInput
    
    init(view: MypagePresenterOutput, model: MypageModelInput) {
        self.view = view
        self.model = model
    }
    
}

extension MypagePresenter: MypagePresenterInput {
    func viewDidAppear() {
        view.setNavigationBarTitle(title: "マイページ")
        model.loadData { success in
            switch (success) {
            case false:
                DispatchQueue.main.async {
                    // debug: エラーダイアログ表示
                    self.view.reloadTableView()
                }
            case true:
                DispatchQueue.main.async {
                    self.view.reloadTableView()
                }
            }
        }
    }
    
    func getCommentCellInfo(at index: Int) -> CommentCellInfo? {
        let comments = model.getComments()
        guard
            let user = model.getUser(),
            0 <= index, index < comments.count
        else {
            return nil
        }
        let c = comments[index]
        
        return CommentCellInfo(userName: user.name, text: c.text)
    }
    func numberOfSections() -> Int {
        1// debug: 本来は、日付の数だけ必要 -> もっと簡単な仕様にできるかもなので保留
    }
    func tableView(numberOfRowsInSection: Int) -> Int {
        model.getComments().count
    }
}
