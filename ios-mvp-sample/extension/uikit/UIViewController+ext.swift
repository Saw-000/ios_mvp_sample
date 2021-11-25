//
//  UIViewController+ext.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNavigationBarTitle(_ title: String?) {
        navigationItem.title = title
    }
    
    func presentAlert(_ info: AlertInfo) {
        
        let avc = UIAlertController(
            title: info.title,
            message: info.message,
            preferredStyle: info.style.convert())
        
        for buttonInfo in info.buttonInfos {
            let action = UIAlertAction(
                title: buttonInfo.buttonTitle,
                style: buttonInfo.buttonType.convert()) { _ in
                    buttonInfo.completion?()
                }
            avc.addAction(action)
        }
        
        present(avc, animated: true)
    }
}
