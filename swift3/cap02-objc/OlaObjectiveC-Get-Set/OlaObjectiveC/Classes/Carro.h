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
    NSString *nome;
    int ano;
}
- (void) setNome:(NSString*)_nome;
- (NSString *) getNome;
- (void) setAno:(int)_ano;
- (int) getAno;

- (Carro *) initWithNome:(NSString *)_nome andAno:(int)_ano;

- (void) acelerarComVelocidade:(int) velocidade eDistancia:(int) distancia;

@end
