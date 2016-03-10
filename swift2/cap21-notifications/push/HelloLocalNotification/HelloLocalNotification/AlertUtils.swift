//
//  Alerta.swift
//  Carros
//
//  Created by Ricardo Lecheta on 6/28/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class AlertUtils {

    class func alert(msg : String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

}