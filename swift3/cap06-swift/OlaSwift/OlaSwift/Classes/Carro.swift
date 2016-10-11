
//
//  class Carro - CombustivelFlex {      var nome- String? = nil     var ano- Int? = nil .swift
//  OlaSwift
//
//  Created by Ricardo Lecheta on 8/19/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

class Carro : CombustivelFlex, Equatable {

    var nome:String
    var ano:Int
    
    init(nome:String, ano: Int) {
        self.nome = nome
        self.ano = ano
    }
    convenience init(nome:String) {
        self.init(nome:nome, ano:1950)
    }
    
    func acelerarComVelocidade(_ velocidade: Int) {
        print("Acelerar para: \(velocidade) km/H")
    }
    
    func acelerarComVelocidade(_ velocidade: Int, distancia: Int) throws {
        print("Acelerar para \(velocidade) km/H e Distância: \(distancia) metros")
        if (velocidade > 120) {
            throw VelocidadeException.rapido
        }
    }
    
    func getDescricao() -> String {
        let s = "Carro: \(self.nome), ano: \(self.ano)"
        return s
    }
    
    // Protocolo CombustivelAlcool
    func abastecerComAlcool() {
        print("Abastecendo com Álcool")
    }
    
    // Protocolo CombustivelGasolina
    func abastecerComGasolina() {
        print("Abastecendo com Gasolina")
    }
}

func == (lhs: Carro, rhs: Carro) -> Bool {
        return lhs.nome == rhs.nome
}
