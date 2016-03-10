//
//  ViewController.swift
//  HelloGestos
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet var imagem: UIImageView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap
        let recognizer = UITapGestureRecognizer(target: self, action: "onTap")
        recognizer.numberOfTapsRequired = 1
        recognizer.delegate = self
        self.imagem.addGestureRecognizer(recognizer)
        
        // Swipe Left
        let recognizerLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        recognizerLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.imagem.addGestureRecognizer(recognizerLeft)

        // Swipe Right
        let recognizerRight = UISwipeGestureRecognizer(target: self, action: "swipeRight")
        recognizerRight.direction = UISwipeGestureRecognizerDirection.Right
        self.imagem.addGestureRecognizer(recognizerRight)
    }

    func onTap() {
        print("onTap")
    }
    
    func swipeLeft() {
        print("swipeLeft")
    }

    func swipeRight() {
        print("swipeRight")
    }
}

















