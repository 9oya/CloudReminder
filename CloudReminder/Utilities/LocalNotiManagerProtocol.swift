//
//  LocalNotiManagerProtocol.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UserNotifications

protocol LocalNotiManagerProtocol {
    func fetchScheduledNotiRquests(completion: @escaping ([UNNotificationRequest]) -> Void)
    
    func removeNotification(id: String)
    
    func schedule()
}
