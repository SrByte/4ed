//
//  Carro.m
//  OlaObjectiveC
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import "Carro.h"
#import "VelocidadeException.h"
#import "NSString+Utils.h" // importe a category aqui

@interface Carro ()
- (void)imprimirPrivado; // Aqui são declarados os métodos privados. O hífen ‘-’
// indica que é um método de instância
@end

@implementation Carro

@synthesize ano, nome;

- (Carro *) initWithNome:(NSString *)_nome andAno:(int)_ano {
    self = [super init];
    if (self) {
        // Se a inicialização foi bem sucedida
        [self setNome:_nome];
        [self setAno:_ano];
    }
    return self;
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

- (void) imprimir {
    // Utiliza o self para acessar as propriedades (é opcional, mas diferencia uma
    // propriedade de uma variável local)
    [self imprimirPrivado];
}

- (void)imprimirPrivado {
    // Aqui você implementa o método normalmente. A diferença é que ele foi declarado
    // no arquivo .m, e portanto é privado
    NSLog(@"Privado Nome: %@, Ano: %d", self.nome, self.ano);
    
    // O método toString da string "nome" foi definido na category
    NSLog(@"Carro Category: %@", [self.nome trim]);
}

#pragma mark equals e hash
- (BOOL)isEqual:(id)object {
    // Compara pelo nome
    Carro *c = (Carro *) object;
    return [nome isEqual:c.nome];
}
- (NSUInteger)hash {
    // Retorna a hash (número que identifica o objeto)
    return nome.hash;
}

@end