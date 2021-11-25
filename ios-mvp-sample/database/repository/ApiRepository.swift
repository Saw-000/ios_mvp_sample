//
//  ApiRepository.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

class ApiRepository {
    // ログインユーザid
    static var loginUserId: UUID? = DebugDatabase.loginUserId
    
    // ユーザ取得
    static func getUser(completion: @escaping (User?) -> Void) {
        guard let id = loginUserId else {
            completion(nil)
            return
        }
        Api.getUser(id: id, completion: completion)
    }
    
    // ユーザが作成したコメント取得
    static func getComments(completion: @escaping ([Comment]?) -> Void) {
        guard let id = loginUserId else {
            completion(nil)
            return
        }
        Api.getComments(createdBy: id) { comments in
            completion(comments)
        }
    }
    
    // リスト内のコメント取得
    static func getComments(in listId: UUID, completion: @escaping ([Comment]?) -> Void) {
        Api.getComments(in: listId) { comments in
            completion(comments)
        }
    }
    
    static func getCommentsInArea(completion: @escaping ([Comment]?) -> Void) {
        Api.getCommentsInArea { comments in
            completion(comments)
        }
    }
    
    // ユーザが作成したコメントリスト取得
    static func getCommentList(completion: @escaping ([CommentList]?) -> Void) {
        guard let id = loginUserId else {
            completion(nil)
            return
        }
        return Api.getCommentList(createdBy: id) { lists in
            completion(lists)
        }
    }
    
    // ユーザへの通知取得
    static func getNotifications(completion: @escaping ([Notification]?) -> Void) {
        guard let id = loginUserId else {
            completion(nil)
            return
        }
        return Api.getNotifications(to: id, completion: completion)
    }
    
    // コメントリスト作成
    static func createCommentList(list: CommentList, completion: @escaping (Bool) -> Void) {
        Api.createCommentList(list: list, completion: completion)
    }
    
    // コメントリスト作成
    static func createComment(comment: Comment, completion: @escaping (Bool) -> Void) {
        Api.createComment(comment: comment, completion: completion)
    }
}
