//
//  MypageModel.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol MypageModelInput {
    func loadData(completion: @escaping (Bool) -> Void)
    func getUser() -> User?
    func getComments() -> [Comment]
}

class MypageModel {
    private var user: User?
    private var comments = [Comment]()
}

extension MypageModel: MypageModelInput {
    func loadData(completion: @escaping (Bool) -> Void) {
        // ユーザ取得
        ApiRepository.getUser { newUser in
            guard let newUser = newUser else {
                completion(false)
                return
            }
            // コメント取得
            ApiRepository.getComments { cms in
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
}
