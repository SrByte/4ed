//
//  MeuPrimeiroViewController.m
//  BemVindo
//
//  Created by Ricardo Lecheta on 11/19/13.
//  Copyright (c) 2013 Ricardo Lecheta. All rights reserved.
//

#import "MeuPrimeiroViewController.h"

@interface MeuPrimeiroViewController ()

@end

@implementation MeuPrimeiroViewController

#pragma mark - View lifecycle
-(void)viewDidLoad {
    meuPrimeiroLabel.text = @"Tela iniciada com sucesso!";
}

- (IBAction)olaMundo:(id)sender {
    NSLog(@"Olá");
    meuPrimeiroLabel.text = @"Olá Mundo iPhone!"; // Vamos alterar o texto do label ao clicar no botão
}

@end
