//
//  Comment.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

struct Comment {
    var text: String?
    var creatorId: UUID
    var createdDate: String
    
    var id: UUID = UUID()
}
