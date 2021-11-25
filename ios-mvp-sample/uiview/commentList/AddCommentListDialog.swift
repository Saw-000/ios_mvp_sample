//
//  AddCommentListDialog.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation
import UIKit

class AddCommentListDialog: XibOwnerView {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var publicSwitch: UISwitch!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    // コールバック
    var completion: ((AddCommentListDialogCallbackInfo?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        addEvent()
    }
    
    // イベント設定
    private func addEvent() {
        cancelButton.addTarget(self, action: #selector(onCancelButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(onAddButton), for: .touchUpInside)
    }
    @objc private func onCancelButton(_ b: UIButton) {
        completion?(nil)
    }
    @objc private func onAddButton(_ b: UIButton) {
        // 入力情報のチェック
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty
        else {
            // debug: 不正値の警告
            return
        }
        
        // 新規リスト情報をコールバック
        let info = AddCommentListDialogCallbackInfo(
            title: title,
            description: description,
            isPublic: publicSwitch.isOn
        )
        completion?(info)
    }
}

extension AddCommentListDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
