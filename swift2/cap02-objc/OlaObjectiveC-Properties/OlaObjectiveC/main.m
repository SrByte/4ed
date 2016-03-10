//
//  main.m
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carro.h"
#import "VelocidadeException.h"
#import "PostoDeGasolina.h"
#import "Exemplos.h"
#import "NSString+Utils.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Carro *c = [[Carro alloc] initWithNome:@"Fusca" andAno:1934];
        
        NSString *nome = c.nome;
        int ano = c.ano;
        NSLog(@"Carro %@ [%d]", nome, ano);
        
        @try {
            // Velocidade OK
            [c acelerarComVelocidade:120 eDistancia:1000];
            
            // Velocidade não permitida
            [c acelerarComVelocidade:121 eDistancia:1000];
        }
        @catch (VelocidadeException *e) {
            NSLog(@"Erro: %@", [e reason]);
        }
        @finally {
        }
        
        // Posto de Gasolina (exemplo de polimorfismo)
        // Abastecendo de álcool ou gasolina
        [PostoDeGasolina abastecerCarroComAlcool:c];
        
        // Teste de como utilizar o self.nome e self.ano das properties
        [c imprimir];
        
        // Exemplo de Array
        [Exemplos exemploArray];
        
        // Exemplo Dictionary
        [Exemplos exemploDictionary];
        
        // Comparar objetos
        [Exemplos exemploEquals];
        
        // Protocolos: "isKindOfClass:" e "conformsToProtocol:"
        [Exemplos exemploInstanceof];
        
        // Trim
        NSString* s = @" Fusca ";
        NSLog(@"[%@]",s);
        NSLog(@"[%@]",[s trim]);
        
    }
    return 0;
}

