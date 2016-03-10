//
//  NSString+Utils.m
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *) trim {
    // Retorna uma string sem os espaços no início e fim
    NSString *s = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return s;
}

@end
