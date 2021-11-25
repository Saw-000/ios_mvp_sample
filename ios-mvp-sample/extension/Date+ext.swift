//
//  Date+ext.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/06.
//

import Foundation

extension Date {
    // to string with format
    public func toString(format: String = "yyyy/MM/dd HH:mm:ss") -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
