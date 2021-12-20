//
//  CommentListPresenter.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol CommentListPresenterInput {
    func viewDidAppear()
    func getCommentCellInfo(at index: Int) -> CommentCellInfo?
    func numberOfSections() -> Int
    func tableView(numberOfRowsInSection: Int) -> Int
    func dispatchViewEvent(_ event: CommentListViewEvent)
}
protocol CommentListPresenterOutput: AnyObject {
    func setNavigationBarTitle(title: String?)
    func reloadTableView()
    func presentAddCommentListDialog(
        completion: @escaping (AddCommentListDialogCallbackInfo?) -> Void
    )
    func presentAlert(info: AlertInfo)
}


class CommentListPresenter {
    // view
    private weak var view: CommentListPresenterOutput!
    
    // model
    private var model: CommentListModelInput
    
    init(view: CommentListPresenterOutput, model: CommentListModelInput) {
        self.view = view
        self.model = model
    }
    
}

extension CommentListPresenter: CommentListPresenterInput {
    func viewDidAppear() {
        view.setNavigationBarTitle(title: "リスト")
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
        guard
            let user = model.getUser(),
            let comments = model.getCurrentListComments(),
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
        model.getCurrentListComments()?.count ?? 0
    }
    
    // dispatch view events
    func dispatchViewEvent(_ event: CommentListViewEvent) {
        switch event {
            
        case .ADD_NEW_LIST_BUTTON:
            view.presentAddCommentListDialog { info in
                guard
                    let userId = self.model.getUser()?.id,
                    let info = info
                else {
                    // debug: エラーダイアログ
                    return
                }
                let newList = CommentList(title: info.title, creatorId: userId, commentIds: [])
                self.model.createCommentList(list: newList) { success in
                    DispatchQueue.main.async {
                        self.view.presentAlert(
                            info: AlertInfo(
                                title: nil,
                                message: success ? "新しいリストを作成しました" : "リストの作成に失敗しました",
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
            
        case .COMMENT_CELL_SELECTED(let indexPath):
            print("some process with: \(indexPath)")
        }
    }
}
