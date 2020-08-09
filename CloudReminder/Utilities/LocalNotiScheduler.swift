//
//  LocalNotiScheduler.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UserNotifications

class LocalNotiScheduler: LocalNotiSchedulerProtocol {
    var notiMOArr = [NotiMO]()
    
    func fetchScheduledNotiRquests(completion: @escaping ([UNNotificationRequest]) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notiRequests) in
            completion(notiRequests)
        }
    }
    
    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        print("Notification removed! --- ID = \(id)")
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .notDetermined:
                break
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
}

extension LocalNotiScheduler {
    private func collapseLocalNotifications() -> [NotiModel] {
        var notiModels = [NotiModel]()
        
        for notiMO in notiMOArr {
            
            if !notiMO.isOn || notiMO.notiGroupMO == nil {
                // Skip the loop when notification is off or notifMO has been deleted from notiGroupMO.
                continue
            }
            
            let sameDateNotiModels = notiModels.filter { "\($0.hour)-\($0.minute)-\($0.weekCode)" == "\(notiMO.notiGroupMO!.hour)-\(notiMO.notiGroupMO!.minute)-\(notiMO.weekCode)"}
            
            if sameDateNotiModels.isEmpty {
                
                // Create a new notifiaction.
                let newNotiModel = NotiModel(id: notiMO.id!.uuidString, title: notiMO.notiGroupMO!.title!, body: notiMO.notiGroupMO!.content!, hour: Int(notiMO.notiGroupMO!.hour), minute: Int(notiMO.notiGroupMO!.minute), weekCode: Int(notiMO.weekCode))
                notiModels.append(newNotiModel)
            } else {
                
                // Collapse notifications that have same date.
                let body = """
                \(sameDateNotiModels.first!.body)
                \(notiMO.notiGroupMO!.content!)
                """
                let newNotiModel = NotiModel(id: sameDateNotiModels.first!.id, title: "", body: body, hour: sameDateNotiModels.first!.hour, minute: sameDateNotiModels.first!.minute, weekCode: sameDateNotiModels.first!.weekCode)
                var newNotiModels = notiModels.filter { "\($0.hour)-\($0.minute)-\($0.weekCode)" != "\(notiMO.notiGroupMO!.hour)-\(notiMO.notiGroupMO!.minute)-\(notiMO.weekCode)"}
                newNotiModels.append(newNotiModel)
                notiModels = newNotiModels
            }
        }
        
        return notiModels
    }
    
    private func scheduleNotifications() {
        let notiModels: [NotiModel] = collapseLocalNotifications()
        
        for (idx, notiModel) in notiModels.enumerated() {
            let content = UNMutableNotificationContent()
            content.title = notiModel.title
            content.body = notiModel.body
            content.sound = .default
            
            var dateComponent = DateComponents()
            dateComponent.hour = notiModel.hour
            dateComponent.minute = notiModel.minute
            dateComponent.weekday = notiModel.weekCode
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 120, repeats: false)
            // let trigger = UNLocationNotificationTrigger(triggerWithRegion: region, repeats: false)
            
            let request = UNNotificationRequest(identifier: notiModel.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                guard error == nil else {
                    return
                }
                print("Notification scheduled! --- ID = \(notiModel.id) - \(idx + 1)")
                print("Hour: \(notiModel.hour), Minute: \(notiModel.minute), WeekCode: \(notiModel.weekCode)")
            }
        }
    }
}
