//
//  ViewLegal.swift
//  HelloQuartz2D
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit
import QuartzCore

class ViewLegal: UIView {
    
    var x: Int = 100
    var y: Int = 100
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect)  {
        desenhaFundoBranco()
        desenhaLinha()
        desenhaQuadrado()
        desenhaPath()
        desenhaCirculo()
        desenhaImagem()
        
        // Demo touch
        desenhaCirculoTouch()
    }
    
    // Fundo branco
    func desenhaFundoBranco() {
        // Recupera o contexto
        let context = UIGraphicsGetCurrentContext()

        // Branco: Cor de preenchimento
        let color = UIColor.whiteColor()
        CGContextSetFillColorWithColor(context, color.CGColor)

        // Quadrado preeenchido
        CGContextFillRect(context, CGRect(x: 0, y: 0, width:self.frame.size.width, height: self.frame.size.height))
    }
    
    // Linha azul na diagonal
    func desenhaLinha() {
        // Recupera o contexto
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 2.0)
        
        // Azul
        let azul = UIColor.blueColor().CGColor
        
        // Cor da linha
        CGContextSetStrokeColorWithColor(context, azul)
        
        // Posiciona no 0,0
        CGContextMoveToPoint(context, 0, 0)
        
        // Cria uma linha até o final da tela na diagonal
        //CGContextAddLineToPoint(context, 320, 480)
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height)
        
        // Desenha a linha
        CGContextStrokePath(context)
    }
    
    // Desenha um Quadrado
    func desenhaQuadrado() {
        // Recupera o contexto
        let context = UIGraphicsGetCurrentContext()

        // Azul
        let color = UIColor.blueColor()

        // Cor da linha
        CGContextSetStrokeColorWithColor(context, color.CGColor)

        // Quadrado
        CGContextAddRect(context, CGRect(x:10, y:190, width:100, height:100))

        // Desenha
        CGContextStrokePath(context);
    }
    
    // Desenha um Path (caminho)
    func desenhaPath() {
        // Recupera o contexto
        let context = UIGraphicsGetCurrentContext()
        
        // Azul
        let color = UIColor.blueColor()
        
        // Cor da linha
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        
        // Posiciona o pincel na coordenada 0,0
        CGContextMoveToPoint(context, 10, 10)

        // Linha para baixo
        CGContextAddLineToPoint(context, 10, 100)

        // Linha para direita
        CGContextAddLineToPoint(context, 100, 100)

        // Linha para cima
        CGContextAddLineToPoint(context, 100, 10)

        // Linha para esquerda
        CGContextAddLineToPoint(context, 10, 10)

        // Cor de preenchimento
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillPath(context)
        
        // Desenha
        CGContextStrokePath(context);
    }
    
    // Desenha um Círculo
    func desenhaCirculo() {
        // Recupera o contexto
        let context = UIGraphicsGetCurrentContext()
        
        // Azul
        let color = UIColor.blueColor()
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetFillColorWithColor(context, color.CGColor)

        // Círculo
        let x = self.frame.size.width - 110
        CGContextAddEllipseInRect(context, CGRect(x:x, y:10, width:100, height:100))
        
        // Desenha
        CGContextStrokePath(context)
        
        // Círculo preenchido
        CGContextFillEllipseInRect(context, CGRect(x:x, y:120, width:100, height:100))
        
        // Desenha
        CGContextStrokePath(context)
    }
    
    // Desenha uma imagem
    func desenhaImagem() {
        let img = UIImage(named: "mclaren.png")!
        
        // Desenha na posição 10/10
//        let point = CGPoint(x:10, y:10)
//        img.drawAtPoint(point)
        
        let imageRect = CGRect(x:10, y:self.frame.size.height - 100, width:200, height:85)
        img.drawInRect(imageRect)
    }
    
    // Desenha um Círculo
    func desenhaCirculoTouch() {
        // Recupera o contexto
        let context = UIGraphicsGetCurrentContext()
        
        // Azul
        let color = UIColor.greenColor()
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        // Círculo
        CGContextFillEllipseInRect(context, CGRect(x:self.x-25, y:self.y-25, width:50, height:50))
        
        // Desenha
        CGContextStrokePath(context)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if let touch = touches.first {
            // Lê a posicão do touch
            let point = touch.locationInView(self)
            
            self.x = Int(point.x)
            self.y = Int(point.y)
            
            self.setNeedsDisplay()
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        if let touch = touches.first {
            // Lê a posicão do touch
            let point = touch.locationInView(self)
            
            self.x = Int(point.x)
            self.y = Int(point.y)
            
            self.setNeedsDisplay()
        }

        super.touchesBegan(touches, withEvent:event)
    }
    
}




































