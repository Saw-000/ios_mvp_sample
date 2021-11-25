//
//  Api.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

class Api {
    // ユーザ取得
    static func getUser(id: UUID, completion: @escaping (User?) -> Void) {
        let user = DebugDatabase.getUser(id: id)
        completion(user)
    }
    
    // ユーザが作成したコメント取得
    static func getComments(createdBy userId: UUID, completion: @escaping ([Comment]) -> Void) {
        let comments = DebugDatabase.getComments(createdBy: userId)
        completion(comments)
    }
    
    // リストに紐づくコメントの取得
    static func getComments(in listId: UUID, completion: @escaping ([Comment]?) -> Void) {
        let comments = DebugDatabase.getComments(in: listId)
        completion(comments)
    }
    
    // 有効範囲内のコメントを取得
    static func getCommentsInArea(completion: @escaping ([Comment]?) -> Void) {
        let comments = DebugDatabase.getCommentsInArea()
        completion(comments)
    }
    
    // ユーザが作成したコメントリスト取得
    static func getCommentList(createdBy userid: UUID, completion: @escaping ([CommentList]) -> Void) {
        let list = DebugDatabase.getCommentList(createdBy: userid)
        completion(list)
    }
    
    // ユーザへの通知取得
    static func getNotifications(to userid: UUID, completion: @escaping ([Notification]?) -> Void) {
        let notifications = DebugDatabase.getNotifications(to: userid)
        completion(notifications)
    }
    
    // コメントリスト作成
    static func createCommentList(list: CommentList, completion: @escaping (Bool) -> Void) {
        completion(false)// debug: 実装
    }
    
    // コメント作成
    static func createComment(comment: Comment, completion: @escaping (Bool) -> Void) {
        completion(false)// debug: 実装
    }
}


// デバッグ用のdatabase
class DebugDatabase {
    private static var userIds: [UUID] = [ UUID(), UUID() ]
    private static var commentIds: [UUID] = [ UUID(), UUID(), UUID(), UUID(), UUID(), ]
    private static var commentListIds: [UUID] = [ UUID(), UUID() ]
    
    // ユーザ
    private static var users: [User] {
        [
            User(
                name: "me",
                listIds: [
                    commentListIds[0],
                    commentListIds[1]
                ],
                id: userIds[0]
            ),
            User(
                name: "friend1",
                listIds: [
                    commentListIds[0]
                ],
                id: userIds[1])
        ]
    }
    // コメント
    private static var comments: [Comment] {
        [
            Comment(
                text: "キーマカレー",
                creatorId: userIds[0],
                createdDate: "2021/8/10",
                id: commentIds[0]
            ),
            Comment(
                text: "グリーンカレー",
                creatorId: userIds[0],
                createdDate: "2021/8/20",
                id: commentIds[1]
            ),
            Comment(
                text: "洋梨",
                creatorId: userIds[1],
                createdDate: "2021/11/11",
                id: commentIds[2]
            ),
            Comment(
                text: "カレーぱん",
                creatorId: userIds[1],
                createdDate: "2021/11/11",
                id: commentIds[3]
            ),
            Comment(
                text: "森",
                creatorId: userIds[1],
                createdDate: "2021/11/11",
                id: commentIds[4]
            ),
        ]
    }
    // コメントリスト
    private static var commentLists: [CommentList] {
        [
            CommentList(
                title: "リスト: カレー",
                creatorId: userIds[0],
                commentIds: [
                    commentIds[0],
                    commentIds[1],
                    commentIds[3],
                ],
                id: commentListIds[0]
            ),
            CommentList(
                title: "リスト: 緑",
                creatorId: userIds[0],
                commentIds: [
                    commentIds[1],
                    commentIds[2],
                    commentIds[4],
                ],
                id: commentListIds[1]
            )
        ]
    }
    
    // 通知
    static var notifications: [ UUID: [Notification] ] {
        [
            userIds[0]: [
                Notification(
                    type: .FOLLOWED,
                    contents: NotificationContents(
                        followedContent: NotificationFollowedContent(
                            followedUserId: userIds[0],
                            followingUserId: userIds[1],
                            date: "2021/11/05"),
                        listFollowedContent: nil,
                        repliedContent: nil)
                ),
                Notification(
                    type: .FOLLOWED,
                    contents: NotificationContents(
                        followedContent: NotificationFollowedContent(
                            followedUserId: userIds[0],
                            followingUserId: userIds[1],
                            date: "2021/11/04"),
                        listFollowedContent: nil,
                        repliedContent: nil)
                )
            ],
            userIds[1]: [
                
            ],
        ]
    }
    
    // ログインユーザ
    static var loginUserId: UUID { userIds[0] }
    
    // ユーザ取得
    static func getUser(id: UUID) -> User? {
        for user in users {
            if user.id == id {
                return user
            }
        }
        return nil
    }
    
    // ユーザが作成したコメント取得
    static func getComments(createdBy userId: UUID) -> [Comment] {
        comments.filter { $0.creatorId == userId }
    }
    
    // リストに紐づくコメントの取得
    static func getComments(in listId: UUID) -> [Comment]? {
        for list in commentLists {
            if list.id == listId {
                var listComments = [Comment]()
                for comment in comments {
                    if list.commentIds.contains(comment.id) {
                        listComments.append(comment)
                    }
                }
                return listComments
            }
        }
        return nil
    }
    
    // ユーザが作成したコメントリストの取得
    static func getCommentList(createdBy userid: UUID) -> [CommentList] {
        commentLists.filter { $0.creatorId == userid }
    }
    
    // 有効範囲内のコメント手おtく
    static func getCommentsInArea() -> [Comment] {
        var comments = [Comment]()
        for i in 0...100 {
            comments.append(
                Comment(text: "\(i)個目のコメント\nこんにちは",
                        creatorId: loginUserId,
                        createdDate: Date().toString())
            )
        }
        return comments
    }
    
    // ユーザへの通知取得
    static func getNotifications(to userid: UUID) -> [Notification]? {
        return notifications[userid]
    }
}
