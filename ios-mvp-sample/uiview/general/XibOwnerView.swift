//
//  XibOwnerView.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

// XibのFileOwnerになるView
class XibOwnerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        self.setXib()
        isOpaque = false
        backgroundColor = .clear
    }

    // XibのUIをViewに加える
    private func setXib() {
        let view = loadXib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view
        addSubview(view)
        
        // xibの外枠の制約をviewの大きさに合わせる
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    //XibのUIを作成
    private func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
