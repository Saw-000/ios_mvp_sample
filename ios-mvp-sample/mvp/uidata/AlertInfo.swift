//
//  AlertInfo.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/06.
//

import Foundation
import UIKit

struct AlertInfo {
    var title: String?
    var message: String?
    var style: AlertStyle
    var buttonInfos: [AlertButtonInfo]
}

enum AlertStyle {
    case ALERT
    case ACTION_SHEET
    
    func convert() -> UIAlertController.Style {
        switch self {
        case .ALERT: return .alert
        case .ACTION_SHEET: return .actionSheet
        }
    }
}
