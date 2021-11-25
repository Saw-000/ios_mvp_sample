//
//  CommentListModel.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol CommentListModelInput {
    func loadData(completion: @escaping (Bool) -> Void)
    func getUser() -> User?
    func getCommentLists() -> [CommentList]
    func getCurrentList() -> CommentList?
    func getCurrentListComments() -> [Comment]?
    func createCommentList(list: CommentList, completion: @escaping (Bool) -> Void)
}

class CommentListModel {
    private var user: User?
    private var commentLists: [CommentList] = []
    private var currentList: CommentList?
    private var currentListComments: [Comment]?
}

extension CommentListModel: CommentListModelInput {
    // ユーザの取得
    func loadData(completion: @escaping (Bool) -> Void) {
        ApiRepository.getUser { newUser in
            guard let newUser = newUser else {
                completion(false)
                return
            }
            
            // ユーザに紐づくコメントリストの取得
            ApiRepository.getCommentList { lists in
                guard let lists = lists else {
                    completion(false)
                    return
                }
                
                guard let firstList = lists.first else {// 一つもリストを保持していない
                    // 情報の保持
                    self.user = newUser
                    self.commentLists = lists
                    completion(true)
                    return
                }
                
                // currentコメントリストの取得
                ApiRepository.getComments(in: firstList.id) { comments in
                    guard let comments = comments else {
                        completion(false)
                        return
                    }

                    // 情報の保持
                    self.user = newUser
                    self.commentLists = lists
                    self.currentList = lists.first
                    self.currentListComments = comments
                    completion(true)
                }
            }
        }
    }
    
    func getUser() -> User? {
        user
    }
    
    func getCommentLists() -> [CommentList] {
        commentLists
    }
    
    func getCurrentList() -> CommentList? {
        currentList
    }
    
    func getCurrentListComments() -> [Comment]? {
        currentListComments
    }
    
    func createCommentList(list: CommentList, completion: @escaping (Bool) -> Void) {
        ApiRepository.createCommentList(list: list) { success in
            completion(success)
        }
    }
}
