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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if let touch = touches.first {
            let position = touch.locationInNode(self)
            
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
                let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
                sprite!.runAction(SKAction.repeatActionForever(action))
            } else {
                // Se existe verifica se o touch foi no sprite
                if(sprite!.containsPoint(position)) {
                    // Remove o sprite do cenário se tocou nele
                    sprite!.removeFromParent()
                    sprite = nil
                } else {
                    // Move o sprite para a nova localização
                    let action = SKAction.moveTo(position, duration:1)
                    sprite!.runAction(SKAction.repeatActionForever(action))
                }
            }
        }
        super.touchesBegan(touches , withEvent:event)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
