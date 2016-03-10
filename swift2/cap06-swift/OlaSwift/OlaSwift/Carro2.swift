//
//  Carro.swift
//  OlaSwift
//
//  Created by Ricardo Lecheta on 10/28/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

class Carro2 {
    var nome:String!
    var ano:Int!
    init?(nome:String, ano: Int) {
        if(nome == "CarroQueNaoExiste") {
            return nil
        }
        self.nome = nome
        self.ano = ano
    }
    convenience init?(nome:String) {
        self.init(nome:nome, ano:1950)
        self.nome = nome
    }
}