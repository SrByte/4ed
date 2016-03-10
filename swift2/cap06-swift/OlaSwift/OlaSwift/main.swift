//
//  main.swift
//  OlaSwift
//
//  Created by Ricardo Lecheta on 8/19/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

print("Hello, World!")

func testeVar() {

    let a:Int = 1
    let b = 2

    var nome = "Ricardo"
    nome += " Lecheta"

    print("Olá \(nome), o resultado da soma é: \(a+b), qtde caracteres \(nome.characters.count)")
}

func testeVarOpcional() {
    
    var nome:String?
    
    nome = "Ricardo Lecheta"

    // Não compila pois a variável está sendo utilizada sem inicializar
    if let s = nome {
        print("Olá \(s)")
    } else {
        print("Olá desconhecido")
    }
}

func testeConstrutor() {
    let c = Carro(nome:"Fusca",ano:1934)

    print("Carro: \(c.nome), ano: \(c.ano)")
}

func testeConstrutorConvenience() {
    let c = Carro(nome:"Fusca")
    
    print("Carro: \(c.nome), ano: \(c.ano)")
}

func testeConstrutor_FailableInitializers() {
    var c = Carro2(nome:"CarroQueNaoExiste",ano:1934)
    print("A: Carro \(c)")
    if(c != nil) {
        print("B: Carro: \(c!.nome), ano: \(c!.ano)")
    }
    
    c = Carro2(nome:"Fusca",ano:1934)
    print("C: Carro \(c)")
    if(c != nil) {
        print("D: Carro: \(c!.nome), ano: \(c!.ano)")
    }
}

func testeMetodoAcelerar() {
    let c = Carro(nome:"Fusca",ano:1934)
    
    c.acelerarComVelocidade(100);
    
    try! c.acelerarComVelocidade(110, distancia: 1000)
    
    try! c.acelerarComVelocidade(122, distancia: 1000)
    
    do {
        try c.acelerarComVelocidade(121, distancia: 500)
    }
    catch VelocidadeException.RAPIDO {
        print("Erro, você está andando rápido demais.")
    } catch VelocidadeException.MUITO_RAPIDO {
        print("Erro, você está andando muito rápido.")
    } catch {
        print("Erro genérico")
    }
}


func testeMetodoComRetorno() {
    let c = Carro(nome:"Fusca",ano:1934)
    
    let desc = c.getDescricao()
    print(desc)
}

// Protocolos
func testeProtocolo() {
    
    let c = Carro(nome:"Fusca",ano:1934)
    
    print("Carro: \(c.nome), ano: \(c.ano)")
    try! c.acelerarComVelocidade(110, distancia: 1000)
    
    // Abastecendo de álcool ou gasolina
    PostoDeGasolina.abastecerCarroComAlcool(c)
    PostoDeGasolina.abastecerCarroComGasolina(c)
}

func testeAnyObject() {
    let qualquer:AnyObject = Carro(nome:"Fusca",ano:1934)

    let c = qualquer as? Carro
    
    print("Carro: \(c!.nome), ano: \(c!.ano)")
}

// Extensions
func testeExtensions() {
    
    let c = Carro(nome:"Fusca   ",ano:1934)
    
    print("Carro: [\(c.nome)]")
    print("Carro: [\(c.nome.trim())]")
}

// Array
func testeArray() {
    let c1 = Carro(nome:"Fusca",ano:1934)
    let c2 = Carro(nome:"Chevette",ano:1973)
    let c3 = Carro(nome:"Brasilia",ano:1934)
    
//    var carros:Array<Carro> = []
//    var carros = [c1,c2,c3]
    var carros = Array<Carro>()
    
    carros.append(c1)
    carros.append(c2)
    carros.append(c3)
    
    print("Este array possui \(carros.count) carros.")
    for c in carros {
        print(c.nome)
    }
}

// Dictionary
func testeDictionary() {
    let c1 = Carro(nome:"Fusca",ano:1934)
    let c2 = Carro(nome:"Chevette",ano:1973)
    let c3 = Carro(nome:"Brasilia",ano:1934)

//    var carros = ["c1":c1, "c2":c2, "c3":c3]
//    var carros:[String:Carro] = ["c1":c1, "c2":c2, "c3":c3]
    
    var carros = Dictionary<String,Carro>()
    carros["c1"] = c1
    carros["c2"] = c2
    carros["c3"] = c3
    
    for (chave,valor) in carros {
        print("Chave \(chave), Valor: \(valor.nome)")
    }
    
    // Recupera o Carro "c1" pela chave
    if let carro = carros["c1"] {
        print("Carro: \(carro.nome), ano: \(carro.ano)")
    }
    
}

// Comparar
func testeComparandoObjetos() {
    let c1 = Carro(nome:"Fusca",ano:1934)
    let c2 = Carro(nome:"Fusca",ano:1973)
    
    let b = c1 == c2
    print("Objetos iguais ? \(b) ")
}

// instanceof
func testeTipo() {

    var c:AnyObject
    
    c = Carro(nome:"Fusca",ano:1934)
    
    // Compara se é "c" é do tipo Carro
    let b = c is Carro
    print("Objeto carro é da classe Carro? : \(b)" )
}


func dividir(a:Int,b:Int) throws -> Int {
    if(b == 0) {
        // Estou usando o mesmo erro para facilitar
        throw VelocidadeException.MUITO_RAPIDO
    }
    return a / b
}

func testeDividir() {
    // Faz o try/catch da forma clássica
    do {
        let s = try dividir(1, b: 0)
        print("Resultado \(s)")
    } catch {
        print("Erro ao dividir por Zero")
    }
    
    // Sintaxe try! para forçar a executar
    let s = try! dividir(1,b:2)
    print("Resultado \(s)")
    
    // Mas se der erro, vai travar o programa, cuidado!!!
//    let s2 = try! dividir(1,b:0)
//    print("Resultado \(s2)")
    
    // Sintaxe try? também pode forçar a executar (retorna um Optional)
    let s3 = try? dividir(10,b:2)
    print("Resultado Optional \(s3)")
    
    // Com try?, se der erro vai retornar nil ao invés de travar
    let s4 = try? dividir(10,b:0)
    print("Resultado \(s4)")
}

//testeVar()
//testeVarOpcional()
//testeConstrutor()
//testeConstrutorConvenience()
//testeConstrutor_FailableInitializers()
//testeMetodoAcelerar()
//testeMetodoComRetorno()
//testeProtocolo()
//testeAnyObject()
//testeExtensions()
//testeArray()
//testeDictionary()
//testeComparandoObjetos()
//testeTipo()
testeDividir()
