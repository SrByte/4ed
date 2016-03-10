//
//  CombustivelFlex.h
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CombustivelAlcool.h"
#import "CombustivelGasolina.h"

@protocol CombustivelFlex <CombustivelAlcool, CombustivelGasolina>

@end
