//
//  PostoDeGasolina.m
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import "PostoDeGasolina.h"

@implementation PostoDeGasolina

+ (void)abastecerCarroComAlcool:(NSObject<CombustivelAlcool> *)tipoAlcool {
    // Apenas delega para o método do protocolo
    [tipoAlcool abastecerComAlcool];
}
+ (void)abastecerCarroComGasolina:(NSObject<CombustivelGasolina> *)tipoGasolina {
    // Apenas delega para o método do protocolo
    [tipoGasolina abastecerComGasolina];
}

@end
