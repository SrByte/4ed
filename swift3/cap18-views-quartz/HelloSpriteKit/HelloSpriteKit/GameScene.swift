//
//  GameScene.swift
//  HelloSpriteKit
//
//  Created by Ricardo Lecheta on 8/8/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var sprite : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            if(sprite == nil) {
                // Cria o Sprite com a imagem Spaceship.png
                sprite = SKSpriteNode(imageNamed:"Spaceship")
                // Define que a posicão do sprite é a posição do Touch
                sprite!.position = position
                sprite!.xScale = 0.5
                sprite!.yScale = 0.5
                
                // Adiciona o sprite
                self.addChild(sprite!)
                
                // Action para girar
                let action = SKAction.rotate(byAngle: CGFloat(M_PI), duration:1)
                sprite!.run(SKAction.repeatForever(action))
            } else {
                // Se existe verifica se o touch foi no sprite
                if(sprite!.contains(position)) {
                    // Remove o sprite do cenário se tocou nele
                    sprite!.removeFromParent()
                    sprite = nil
                } else {
                    // Move o sprite para a nova localização
                    let action = SKAction.move(to: position, duration:1)
                    sprite!.run(SKAction.repeatForever(action))
                }
            }
        }
        super.touchesBegan(touches , with:event)
    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
