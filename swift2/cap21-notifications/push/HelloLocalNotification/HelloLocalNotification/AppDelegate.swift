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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
       
        // Permissao: Informa o usuário que o aplicativo vai receber local notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert, UIUserNotificationType.Badge], categories: nil
            ))
        
        // Caso 2: Ao axecutar a aplicação verifica se existe alguma notificação
        // (caso o usuário abriu o app pela notificação)
        if(launchOptions != nil) {
            print("launchOptions!")
            if let notification = launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification! {
                // Se existe a notificação
                alerta("Caso 2 \(notification.alertBody!)")
            }
        }

        return true
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        print("didReceiveLocalNotification")
        
        print("Alert Action \(notification.alertAction!)")
        print("Alert Body \(notification.alertBody!)")
        
        alerta("Caso 1 \(notification.alertBody!)")

        // Caso 1: Recebe a notificação aqui, quando o aplicativo está aberto ou em background
        // Zera o número que fica no ícone pois já fizemos a leitura da notificação
        application.applicationIconBadgeNumber = 0
    }

    func alerta(str: String) {
        AlertUtils.alert(str, viewController: self.window!.rootViewController!)
    }

}

