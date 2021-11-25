//
//  HomePresenter.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol HomePresenterInput {
    func viewDidAppear()
    func getCommentCellInfo(at index: Int) -> CommentCellInfo?
    func numberOfSections() -> Int
    func tableView(numberOfRowsInSection: Int) -> Int
    func didTapAddCommentButton()
}
protocol HomePresenterOutput: AnyObject {
    func setNavigationBarTitle(title: String?)
    func reloadTableView()
    func presentAddCommentDialog(completion: @escaping (AddCommentDialogCallbackInfo?) -> Void)
    func presentAlert(info: AlertInfo)
}


class HomePresenter {
    // view
    private weak var view: HomePresenterOutput!
    // model
    private var model: HomeModelInput
    
    init(view: HomePresenterOutput, model: HomeModelInput) {
        self.view = view
        self.model = model
    }
    
}

extension HomePresenter: HomePresenterInput {
    func viewDidAppear() {
        view.setNavigationBarTitle(title: "ホーム")
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
        1// debug: 本来は、日付の数だけ必要っぽい -> もっと簡単な仕様にできるかもなので保留
    }
    
    func tableView(numberOfRowsInSection: Int) -> Int {
        model.getComments().count
    }
    
    func didTapAddCommentButton() {
        view.presentAddCommentDialog { info in
            guard
                let info = info,
                let creatorId = self.model.getUser()?.id
            else {
                // debug: 警告荒tーお
                return
            }
            
            // 新コメントの作成
            let newComment = Comment(
                text: info.text,
                creatorId: creatorId,
                createdDate: Date().toString())
            self.model.createComment(newComment) { success in
                DispatchQueue.main.async {
                    self.view.presentAlert(
                        info: AlertInfo(
                            title: nil,
                            message: success ? "新しいコメントを作成しました" : "コメントの作成に失敗しました",
                            style: .ALERT,
                            buttonInfos: [
                                AlertButtonInfo(
                                    buttonTitle: "OK",
                                    buttonType: .DEFAULT)
                            ]
                        )
                    )
                }
            }
        }
    }
}
