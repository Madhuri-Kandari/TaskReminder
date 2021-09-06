//
//  Task.swift
//  TaskReminder
//
//  Created by M1066900 on 03/06/21.
//

import Foundation
import UserNotifications

class Task:NSObject,Codable{
    var text = ""
    var checked = false
    var dueDate=Date()
    var shouldRemind=false
    var itemId = -1
    
    func toggleCheck(){
        checked.toggle()
    }
    override init() {
        super.init()
        itemId=DataModel.nextTaskItemID()
    }
    func scheduleNotification(){
        removeNotification()
        if shouldRemind && dueDate > Date(){
            let content = UNMutableNotificationContent()
            content.title="Remind"
            content.body=text
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request=UNNotificationRequest(identifier: "\(itemId)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("scheduled notification for \(itemId)")
        }
    }
    deinit {
        removeNotification()
    }
    func removeNotification(){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemId)"])
    }
}



