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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Carro *c = [[Carro alloc] initWithNome:@"Fusca" andAno:1934];
        
        NSString *nome = [c getNome];
        int ano = [c getAno];
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
        
        NSLog(@"OK");
        
    }
    return 0;
}

