//
//  CommentList.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

struct CommentList {
    var title: String
    var creatorId: UUID
    var commentIds: [UUID]
    var id: UUID = UUID()
}
