//
//  VideoUtil.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation
import MediaPlayer

/**
 
 Este codigo está deprecated pois usa a API ate iOS8, classe MPMoviePlayerController.
 
 No app dos carros mostrei o codigo novo com iOS 9 com a classe AVPlayer.
 
 Estou mantendo esse aqui para termos o historico, caso precise utilizar a classe MPMoviePlayerController.
 
**/

class VideoUtil {

    var player : MPMoviePlayerController? = nil
    var playerViewController : MPMoviePlayerViewController? = nil

    // Reproduz o vídeo com um player utilizando uma view como container
    func playFile(file: String, view: UIView) {
    
        // Converte o nome do arquivo em NSURL
        let path = NSBundle.mainBundle().pathForResource(file, ofType: nil)
    
        if(path != nil) {
            let url = NSURL.fileURLWithPath(path!)

            self.playUrl(url, view: view)
        }
    }
    
    // Reproduz o vídeo com um player utilizando uma view como container
    func playUrl(url: NSURL!, view: UIView) {
        // Cria o componente que gerencia o video
        
        if (self.player == nil) {
            self.player = MPMoviePlayerController(contentURL:url)
        
            self.player!.prepareToPlay()
            
            // Configura a view
            self.player!.view.frame = view.bounds
            
            view.addSubview(player!.view)
        }

        // Inicia o video
        self.player!.play()
    }
    
    func pause() {
        if(self.player != nil) {
            self.player!.pause()
        }
    }
    
    func stop() {
        if(self.player != nil) {
            self.player!.stop()
        }
    }
    
    // Reproduz o vídeo em tela cheia
    func playFileFullScreen(file: String, viewController: UIViewController) {
        // Converte o nome do arquivo em NSURL
        let path = NSBundle.mainBundle().pathForResource(file, ofType: nil)
        
        if(path != nil) {
            let url = NSURL.fileURLWithPath(path!)
            
            self.playUrlFullScreen(url, viewController: viewController)
        }
    }
    
    // Reproduz o vídeo em tela cheia
    func playUrlFullScreen(url: NSURL!, viewController: UIViewController) {
        // Cria o controller especializado em reproduzir video
        
        if (self.playerViewController == nil) {
            self.playerViewController = MPMoviePlayerViewController(contentURL:url)

            // Exibe o controller como modal
            viewController.presentMoviePlayerViewControllerAnimated(self.playerViewController)
        }
    }
}