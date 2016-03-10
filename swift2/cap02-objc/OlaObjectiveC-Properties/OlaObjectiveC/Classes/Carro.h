//
//  Carro.h
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CombustivelFlex.h"

@interface Carro : NSObject <CombustivelFlex> {
    // Ao declar a property, estes dois atributos são opcionais. O iOS vai inseri-los se vc nao colocar.
    NSString *nome;
    int ano;
}

@property(nonatomic, retain) NSString* nome; // declara a propriedade
@property(nonatomic, assign) int ano;

- (Carro *) initWithNome:(NSString *)_nome andAno:(int)_ano;

- (void) acelerarComVelocidade:(int) velocidade eDistancia:(int) distancia;

- (void) imprimir;

@end
