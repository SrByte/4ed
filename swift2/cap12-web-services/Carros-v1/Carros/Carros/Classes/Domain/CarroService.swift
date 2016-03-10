//
//  CarroService.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/12/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class CarroService {
    
    // Busca por os carros pelo tipo: esportivos, clássicos ou luxo
    class func getCarrosByTipoFromFile(tipo: String) -> Array<Carro> {
        let file = "carros_" + tipo
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "json")
        
        if(path == nil) {
            // Não encontrou o arquivo no projeto
            return [] // array vazio
        }
        
        // Conteúdo binário do arquivo
        let data = NSData(contentsOfFile: path!)
        
        if(data == nil) {
            // Não conseguiu ler o arquivo
            return [] // array vazio
        }
        
        if (data!.length == 0) {
            print("NSData vazio");
            return [] // array vazio
        }
        
        let carros = self.parserJson(data!)
        
        //let carros = parserXML_DOM(data!)
        
        for c in carros {
            // Atualiza o tipo do carro vamos precisar depois
            c.tipo = tipo
        }
        
        return carros
    }
    
    // Parser JSON
    class func parserJson(data: NSData) -> Array<Carro> {
        
        var carros : Array<Carro> = []
        
        // Faz a leitura do JSON, converte para dictionary
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            // Dictionary para todos os carros
            let jsonCarros: NSDictionary = dict["carros"] as! NSDictionary
            let arrayCarros: NSArray = jsonCarros["carro"] as! NSArray
            
            // Array de carros
            for obj:AnyObject in arrayCarros {
                let dict = obj as! NSDictionary
                let carro = Carro()
                carro.nome = dict["nome"] as! String
                carro.desc = dict["desc"] as! String
                carro.url_info = dict["url_info"] as! String
                carro.url_foto = dict["url_foto"] as! String
                carro.url_video = dict["url_video"] as! String
                carro.latitude = dict["latitude"] as! String
                carro.longitude = dict["longitude"] as! String
                carros.append(carro)
            }
        } catch let error as NSError {
            print("Erro ao ler JSON \(error)")
        }
        // Retorna a lista de carros
        return carros
    }
    
    // Parser de XML com DOM
    class func parserXML_DOM(data: NSData) -> Array<Carro> {
        var carros : Array<Carro> = []
        
        // Lê a tag raiz <carros>
        let document = try? SMXMLDocument(data: data)
        
        if(document == nil) {
            print("Erro ao ler os dados");
            return carros
        }
        
        let root = document!.root as SMXMLElement
        let tagCarros = root.childrenNamed("carro") as NSArray
        
        // Percorre todas as tags <carro>
        for x:AnyObject in  tagCarros {
            let xml = x as! SMXMLElement
            
            let carro = Carro()
            carro.nome = xml.valueWithPath("nome")
            carro.desc = xml.valueWithPath("desc")
            carro.url_info = xml.valueWithPath("url_info")
            carro.url_foto = xml.valueWithPath("url_foto")
            carro.url_video = xml.valueWithPath("url_video")
            if(xml.valueWithPath("latitude") != nil) {
                carro.latitude = xml.valueWithPath("latitude")
            }
            if(xml.valueWithPath("longitude") != nil) {
                carro.longitude = xml.valueWithPath("longitude")
            }
            
            carros.append(carro)
            
        }
        
        return carros
    }
    
    // Parser de XML com SAX
    class func parserXML_SAX(data: NSData) -> Array<Carro> {
        var carros : Array<Carro> = []
        
        let xmlParser = NSXMLParser(data:data)
        
        let carrosParser = XMLCarroParser()
        xmlParser.delegate = carrosParser
        
        // Inicia o parser com o NSXMLParser, o que vai chamar a classe XMLCarroParser
        let ok = xmlParser.parse()
        
        if (ok) {
            // Fez o parser com sucesso, retorna a lista de carros
            carros = carrosParser.carros
            
            let count = carros.count
            
            print("Parser, encontrado \(count) carros");
            
        } else {
            print("Erro no parser");
        }
        
        // Retorna a lista de carros
        return carros
    }
    
    // Retorna um array de carros de forma simples
    class func getCarros() -> Array<Carro> {
        
        var carros : Array<Carro> = []
        
        for (var i = 0; i < 20; i++) {
            let c = Carro()
            c.nome = "Ferrari " + String(i)
            c.desc = "Desc Carro " + String(i)
            c.url_foto = "Ferrari_FF.png"
            c.url_info = "http://www.google.com.br"
            
            // Adiciona o carro no array
            carros.append(c)
        }
        
        return carros
    }
}