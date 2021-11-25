//
//  UIView+ext.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/06.
//

import Foundation
import UIKit

extension UIView {
    // アニメーション付きでViewをリムーブ
    func removeFromSuperViewWithAnimation(
        duration: TimeInterval,
        options: UIView.AnimationOptions,
        animationCompletion: ((Bool) -> Void)? = nil
    ) {
        guard let superView = self.superview else {
            removeFromSuperview()// 念の為
            animationCompletion?(true)
            return
        }
        
        UIView.transition(
            with: superView,
            duration: duration,
            options: options,
            animations: {
                self.removeFromSuperview()
            },
            completion: animationCompletion)
    }
    
    // アニメーション付きでフルスクリーンのViewを追加
    func addFullScreenSubviewWithAnimation(
        v: UIView,
        duration: TimeInterval,
        options: UIView.AnimationOptions,
        animationCompletion: ((Bool) -> Void)? = nil)
    {
        UIView.transition(
            with: self,
            duration: 0.25,
            options: options,
            animations: {
                v.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(v)
                NSLayoutConstraint.activate([
                    v.topAnchor.constraint(equalTo: self.topAnchor),
                    v.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    v.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    v.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                ])
            },
            completion: animationCompletion)
    }
}
