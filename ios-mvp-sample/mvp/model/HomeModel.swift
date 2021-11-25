//
//  HomeModel.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol HomeModelInput {
    func loadData(completion: @escaping (Bool) -> Void)
    func getUser() -> User?
    func getComments() -> [Comment]
    func createComment(_ comment: Comment, completion: @escaping (Bool) -> Void)
}

class HomeModel {
    private var user: User?
    private var comments = [Comment]()
}

extension HomeModel: HomeModelInput {
    func loadData(completion: @escaping (Bool) -> Void) {
        // ユーザ取得
        ApiRepository.getUser { newUser in
            guard let newUser = newUser else {
                completion(false)
                return
            }
            // コメント取得
            ApiRepository.getCommentsInArea { cms in
                guard let cms = cms else {
                    completion(false)
                    return
                }
                
                // 値の保持
                self.user = newUser
                self.comments = cms
                completion(true)
            }
        }
    }
    
    func getUser() -> User? {
        user
    }
    
    func getComments() -> [Comment] {
        comments
    }
    
    func createComment(_ comment: Comment, completion: @escaping (Bool) -> Void) {
        ApiRepository.createComment(comment: comment, completion: completion)
    }
}
