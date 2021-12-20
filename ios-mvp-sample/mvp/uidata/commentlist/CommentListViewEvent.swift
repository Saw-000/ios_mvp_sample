//
//  CommentListViewEvent.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/12/21.
//

import Foundation

// view events on CommentList Screen
enum CommentListViewEvent {
    case ADD_NEW_LIST_BUTTON
    case COMMENT_CELL_SELECTED(IndexPath)
}
