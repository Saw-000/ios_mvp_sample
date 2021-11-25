//
//  UIApplecation+ext.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/06.
//

import Foundation
import UIKit

extension UIApplication {
    static func getWindow() -> UIWindow? {
        shared.windows.first(where: { $0.isKeyWindow })
    }
}
