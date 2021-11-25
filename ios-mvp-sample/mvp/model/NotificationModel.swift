//
//  NotificationModel.swift
//  ios-mvp-sample
//
//  Created by IeSo on 2021/11/05.
//

import Foundation

protocol NotificationModelInput {
    func loadNotifications(completion: @escaping (Bool) -> Void)
    func getNotifications() -> [Notification]
}

class NotificationModel {
    private var notificatoins: [Notification] = []
}

extension NotificationModel: NotificationModelInput {
    func loadNotifications(completion: @escaping (Bool) -> Void) {
        ApiRepository.getNotifications { list in
            guard let list = list else {
                self.notificatoins = []
                completion(false)
                return
            }
            self.notificatoins = list
            completion(true)
            return
        }
    }
    
    func getNotifications() -> [Notification] {
        notificatoins
    }
}
