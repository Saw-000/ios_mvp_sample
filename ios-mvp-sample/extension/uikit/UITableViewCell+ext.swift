//
//  UITableViewCell+ext.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
