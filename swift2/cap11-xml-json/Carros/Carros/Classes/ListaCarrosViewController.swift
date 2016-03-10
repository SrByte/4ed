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
    
    // Tipo do carro
    var tipo = "classicos"

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
        // Para o scroll começar na posição do TableView
        self.automaticallyAdjustsScrollViewInsets = false;
        
        // Registra o CarroCell.xib como UITableViewCell da tabela
        let xib = UINib(nibName: "CarroCell", bundle:nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        // Busca carros
        self.buscarCarros()
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
        
        print("url \(carro.url_foto)")

        // Busca a imagem (problema de performance aqui)
        let data = NSData(contentsOfURL: NSURL(string: carro.url_foto)!)
        if(data != nil) {
            let image = UIImage(data: data!)
            cell.cellImg.image = image
        }

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

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask  {
        // Apenas vertical
        return UIInterfaceOrientationMask.Portrait
    }
    
    @IBAction func alterarTipo(sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        
        switch (idx) {
        case 0:
            self.tipo = "classicos"
        case 1:
            self.tipo = "esportivos"
        default:
            self.tipo = "luxo"
        }
    
        // Buscar os carros pelo tipo selecionado (classico, esportivo, luxo)
        self.buscarCarros()
    }
    
    func buscarCarros() {
        
        self.carros = CarroService.getCarrosByTipoFromFile(tipo)
        
        // Atualiza o TableView
        self.tableView.reloadData()
    }
}
