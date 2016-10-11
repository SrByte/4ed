//
//  Carro.m
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import "Carro.h"
#import "VelocidadeException.h"

@implementation Carro

- (Carro *) initWithNome:(NSString *)_nome andAno:(int)_ano {
    self = [super init];
    if (self) {
        // Se a inicialização foi bem sucedida
        [self setNome:_nome];
        [self setAno:_ano];
    }
    return self;
}

- (void) setNome:(NSString*)_nome {
    nome = _nome;
}
- (NSString *) getNome {
    return nome;
}

- (void) setAno:(int)_ano {
    ano = _ano;
}
- (int) getAno {
    return ano;
}

- (void) acelerarComVelocidade:(int) velocidade eDistancia:(int) distancia {
    NSLog(@"Acelerar com velocidade: %d km/H e Distância: %d metros", velocidade, distancia);
    
    if (velocidade > 120) {
        // throw exception
        NSException *e = [VelocidadeException exceptionWithName: @"VelocidadeException"
                                                         reason: @"Velocidade não permitida, dirija com cuidado." userInfo: nil];
        @throw e;
    }
}

#pragma mark - protocolo combustível
- (void)abastecerComAlcool {
    NSLog(@"Abastecendo com Álcool");
}
- (void) abastecerComGasolina {
    NSLog(@"Abastecendo com Gasolina");
}

@end