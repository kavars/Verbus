//
//  UserNotificationService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 02.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

protocol UserNotificationsProtocol: class {
}

class UserNotificationsService: NSObject, UserNotificationsProtocol {
    lazy var storeVerbsService: StoreVerbsServiceProtocol = StoreVerbsService(modelName: "Curb_your_Verb")
    
    override init() {
        super.init()
        
        self.registerForPushNotification()
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func registerForPushNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                self.scheduleNotification()
            }
        }
    }
    
    func scheduleNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        
        guard let verbs = storeVerbsService.verbsFetch(of: .onLearning) else {
            return
        }
        
        let verb = verbs[Int.random(in: 0..<verbs.count)]
        
        guard let inf = verb.infinitive, let pastSimple = verb.pastSimple, let pastPart = verb.pastParticiple, let translation = verb.translation else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Самое время повторить пару глаголов"
        content.body = "\(inf) \(pastSimple) \(pastPart) - \(translation)"
        
//        let honk = UNNotificationSound(named: UNNotificationSoundName(rawValue: "honk.mp3"))
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

extension UserNotificationsService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        self.scheduleNotification()
        
        completionHandler()
    }
}
