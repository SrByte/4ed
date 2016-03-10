//
//  AppDelegate.swift
//  HelloRemoteNotification
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)

        // Solicitia permissão do usuário
        application.registerUserNotificationSettings(settings)

        print("registerForRemoteNotifications() ")
        
        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    
        print("register \(notificationSettings)")
        
        // Faz o registro para receber remote notifications
        application.registerForRemoteNotifications()
    }
    
    // Fez o registro para receber o Push.
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Aqui imprime o device token único deste dispositivo
        print("didRegisterForRemoteNotificationsWithDeviceToken \(deviceToken)")
    }

    // Falhou para registrar
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("didFailToRegisterForRemoteNotificationsWithError \(error)")
    }

    // Recebeu uma mensagem de Push
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
    {
        print("didReceiveRemoteNotification \(userInfo)")
        
        // userInfo é um NSDictionary
        let dict = userInfo as NSDictionary
        
        // Lê o json dentro de aps { }
        let notification:NSDictionary = dict.objectForKey("aps") as! NSDictionary
        
        // Json da notificação
        print("notification \(notification)")
        
    }

}

