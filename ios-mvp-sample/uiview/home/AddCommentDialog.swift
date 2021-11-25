//
//  AddCommentDialog.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/06.
//

import UIKit
import MapKit

class AddCommentDialog: XibOwnerView {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var completion: ((AddCommentDialogCallbackInfo?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        textView.delegate = self
        textView.inputAccessoryView = createKeyboardDoneButtonToolBar()
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
        guard
            let text = textView.text, !text.isEmpty
                // debug: 地図上位置や画像なども
        else {
            // debug: 不正値の警告
            return
        }
        
        // 新規コメント情報をコールバック
        let info = AddCommentDialogCallbackInfo(
            text: text
        )
        completion?(info)
    }
    
    // keyboardのDoneボタンを作成
    private func createKeyboardDoneButtonToolBar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onKeyboardDoneButton))
        let items = [flexSpace, doneButton]
        toolbar.items = items
        toolbar.sizeToFit()
        return toolbar
    }
    
    // Doneボタンの処理
    @objc private func onKeyboardDoneButton(_ b: UIBarItem) {
        self.endEditing(true)// keyboardを閉じる
    }
}

extension AddCommentDialog: UITextViewDelegate {
    
}
