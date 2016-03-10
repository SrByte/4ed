//
//  Alerta.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/12/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class Alerta {
    
    class func alerta(msg : String, viewController: UIViewController) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            viewController.presentViewController(alert, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
}