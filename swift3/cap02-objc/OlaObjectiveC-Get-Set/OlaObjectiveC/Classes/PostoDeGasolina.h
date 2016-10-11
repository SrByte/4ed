//
//  PostoDeGasolina.h
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CombustivelGasolina.h"
#import "CombustivelAlcool.h"

@interface PostoDeGasolina : NSObject

+ (void) abastecerCarroComAlcool:(NSObject<CombustivelAlcool> *) tipoAlcool;
+ (void) abastecerCarroComGasolina:(NSObject<CombustivelGasolina> *) tipoGasolina;

@end
