//
//  AlertItemInfo.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation
import UIKit

struct AlertButtonInfo {
    var buttonTitle: String
    var buttonType: AlertButtonType
    var completion: (() -> Void)? = nil
}

enum AlertButtonType {
    case DEFAULT
    case CANCEL
    case DESTRUCTIVE
    
    func convert() -> UIAlertAction.Style {
        switch self {
        case .DEFAULT: return .default
        case .CANCEL: return .cancel
        case .DESTRUCTIVE: return .destructive
        }
    }
}
