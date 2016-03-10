//
//  ListaCarrosViewController.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/11/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!

    var carros: Array<Carro> = []
    
    init() {
        super.init(nibName: "ListaCarrosViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Título
        self.title = "Carros"
        
        // delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Registra o CarroCell.xib como UITableViewCell da tabela
        let xib = UINib(nibName: "CarroCell", bundle:nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")

        self.carros = CarroService.getCarros()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Se a variável opcional está inicializada, retorna a quantidade de carros
        return self.carros.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Cria a célula desta linha
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! CarroCell

        let linha = indexPath.row
        
        // Objeto do tipo carro
        let carro = self.carros[linha]

        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc
        cell.cellImg.image = UIImage(named: carro.url_foto)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let linha = indexPath.row
        
        let carro = self.carros[linha]

//        Alerta.alerta("Selecionou o carro: " + carro.nome, viewController: self)
        
        let vc = DetalhesCarroViewController()
        vc.carro = carro
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
}
