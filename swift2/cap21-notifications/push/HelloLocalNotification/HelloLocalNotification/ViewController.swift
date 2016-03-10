//
//  ViewController.swift
//  HelloLocalNotification
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func addLocalNotification() {
    
        print("addLocalNotification")
      
        // Define a Mensagem para exibir ao usuário
        let not = UILocalNotification()
        not.alertBody = "Teste de Mensagem"
        
        // Texto da ação quando o botão com a notificação aparecer
        not.alertAction = "Ação aqui"
    
        // Som
        not.soundName = UILocalNotificationDefaultSoundName
    
        // Incrementa o applicationIconBadgeNumber baseado no que está configurado no UIApplication
        not.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        // Configura a notificação para daqui a 2 segundos
        not.fireDate = NSDate(timeIntervalSinceNow:2)
        not.timeZone = NSTimeZone.defaultTimeZone()
        
        // Agenda a notificação
        UIApplication.sharedApplication().scheduleLocalNotification(not)
        print("Notificação agendada com sucesso")
    }


}

