//
//  CombustivelAlcool.swift
//  OlaSwift
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

protocol CombustivelAlcool {
    func abastecerComAlcool();
}

protocol CombustivelGasolina {
    func abastecerComGasolina();
}

protocol CombustivelFlex : CombustivelAlcool,CombustivelGasolina {

    
}

class PostoDeGasolina {

    class func abastecerCarroComAlcool(tipo: CombustivelAlcool) {
        // Delega para o método do protocolo
        tipo.abastecerComAlcool()
    }
    
    class func abastecerCarroComGasolina(tipo: CombustivelGasolina) {
        // Delega para o método do protocolo
        tipo.abastecerComGasolina()
    }
}