//
//  Daily_push_upApp.swift
//  Daily push up
//
//  Created by Maxence Gama on 04/01/2022.
//
/*
                                               __  __                             ___
                                              |  \/  |__ ___ _____ _ _  __ ___   / __|__ _ _ __  __ _
                                              | |\/| / _` \ \ / -_) ' \/ _/ -_) | (_ / _` | '  \/ _` |
                                              |_|  |_\__,_/_\_\___|_||_\__\___|  \___\__,_|_|_|_\__,_|
                      
   
*/

import SwiftUI

@main
struct Daily_push_upApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        registerForNotification()
        return true
    }
    
    
    func registerForNotification() {
        UIApplication.shared.registerForRemoteNotifications()
        
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
            else {
                
            }
        })
    }
}
