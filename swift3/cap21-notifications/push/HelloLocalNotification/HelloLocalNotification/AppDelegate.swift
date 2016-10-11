//
//  AppDelegate.swift
//  HelloLocalNotification
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        // Permissao: Informa o usuário que o aplicativo vai receber local notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [UIUserNotificationType.sound, UIUserNotificationType.alert, UIUserNotificationType.badge], categories: nil
            ))
        
        // Caso 2: Ao axecutar a aplicação verifica se existe alguma notificação
        // (caso o usuário abriu o app pela notificação)
        if(launchOptions != nil) {
            print("launchOptions!")
            if let notification = launchOptions![UIApplicationLaunchOptionsKey.localNotification] as! UILocalNotification! {
                // Se existe a notificação
                alerta("Caso 2 \(notification.alertBody!)")
            }
        }

        return true
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("didReceiveLocalNotification")
        
        print("Alert \(notification)")
        
        // Caso 1: Recebe a notificação aqui, quando o aplicativo está aberto ou em background
        // Zera o número que fica no ícone pois já fizemos a leitura da notificação
        application.applicationIconBadgeNumber = 0
    }

    func alerta(_ str: String) {
        AlertUtils.alert(str, viewController: self.window!.rootViewController!)
    }

}

