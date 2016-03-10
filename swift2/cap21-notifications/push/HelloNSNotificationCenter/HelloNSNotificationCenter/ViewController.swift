//
//  ViewController.swift
//  HelloNSNotificationCenter
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Se registra para receber mensagens do tipo MINHA_NOTIFICACAO
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "recebeNotificacao", name: "MINHA_NOTIFICACAO", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,name: "MINHA_NOTIFICACAO", object: nil)
    }

    func recebeNotificacao() {
        print("recebeNotificacao OK!")
    }
    
    @IBAction func onTouchEnviarNotificacao() {
        // Teste de Notification
        NSNotificationCenter.defaultCenter().postNotificationName("MINHA_NOTIFICACAO", object:"Ricardo")
    }
}

