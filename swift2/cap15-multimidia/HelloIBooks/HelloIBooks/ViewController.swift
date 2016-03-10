//
//  ViewController.swift
//  HelloIBooks
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBAction func visualizarFigura() {
        
        // Pré-visualização da figura
        
        let path = NSBundle.mainBundle().pathForResource("mclaren.png", ofType: nil)
        
        let url = NSURL.fileURLWithPath(path!)
        
        // Cria o DocumentInteractionController informando a URL
        
        let docController = UIDocumentInteractionController(URL:url)
        
        docController.delegate = self
        
        docController.presentPreviewAnimated(true)
        
    }
    
    @IBAction func visualizarPDF() {
        
        // PDF para abrir
        
        let path = NSBundle.mainBundle().pathForResource("sumario_livro_ios.pdf", ofType: nil)
        
        let url = NSURL.fileURLWithPath(path!)
        
        // Cria o DocumentInteractionController informando a URL
        
        let docController = UIDocumentInteractionController(URL:url)
        
        docController.delegate = self
        
        docController.presentPreviewAnimated(true)
        
    }
    
    @IBAction func abrirIBooks() {
        
        // PDF para abrir
        
        let path = NSBundle.mainBundle().pathForResource("sumario_livro_ios.pdf", ofType: nil)
        
        let url = NSURL.fileURLWithPath(path!)
        
        // Abre o arquivo pdf no iBooks se estiver instalado no device
        
        let iBooksInstalled = UIApplication.sharedApplication().canOpenURL(url)
        
        if(iBooksInstalled) {
            
            print("iBooksInstalled: \(iBooksInstalled)")
            
            // Cria o DocumentInteractionController informando a URL
            
            let docController = UIDocumentInteractionController(URL:url)
            
            docController.delegate = self
            
            docController.presentOpenInMenuFromRect(CGRectZero, inView:self.view, animated: true)
            
        } else {
            print("iBooks não está instalado.")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        
        return self
        
    }
    
}

