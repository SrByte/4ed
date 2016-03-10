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
    
    @IBOutlet var progress: UIActivityIndicatorView!
    
    @IBOutlet var segmentControl: UISegmentedControl!

    // Array com a sintaxe '?' de objeto opcional no Swift
    var carros: Array<Carro>?
    
    // Tipo do carro
    var tipo = "classicos"
    
    // Se é para fazer cache do banco de dados
    var cache = true

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
        
        // Botao Refresh na navigation bar
        let btAtualizar = UIBarButtonItem(title: "Atualizar", style: UIBarButtonItemStyle.Plain, target: self, action: "atualizar")
        self.navigationItem.rightBarButtonItem = btAtualizar
        
        // Recupera o tipo salvo nas preferências
        let idx = Prefs.getInt("tipoIdx")
        let s = Prefs.getString("tipoString")
        if(s != nil) {
            // Como a String é opcional precisamos testar antes
            self.tipo = s
        }
        // Atualiza o índice no segment control
        self.segmentControl.selectedSegmentIndex = idx
        
        print(Utils.isIpad())
        print(Utils.isPortrait())
        if(Utils.isIpad() && Utils.isPortrait()) {
            print("ipad vert")
            self.buscarCarros()
        }
    }
    
    override func viewDidAppear(animated: Bool)  {
        super.viewDidAppear(animated)
    
        // Busca carros
        self.buscarCarros()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Se a variável opcional está inicializada, retorna a quantidade de carros
        return self.carros != nil ? self.carros!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Cria a célula desta linha
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! CarroCell

        let linha = indexPath.row
        
        // Objeto do tipo carro
        let carro = self.carros![linha]

        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc

        // URL
        cell.cellImg.setUrl(carro.url_foto)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let linha = indexPath.row
        
        let carro = self.carros![linha]

        if(Utils.isIphone()) {
            // Faz a navegação
            let vc = DetalhesCarroViewController()
            vc.carro = carro
            self.navigationController!.pushViewController(vc, animated: true)
        } else {
            // Atualiza os detalhes na direita
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let detalhes = appDelegate.detalhesController!
            detalhes.updateCarro(carro)
        }
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
        
        // Salva o tipo nas preferências
        Prefs.setInt(idx, chave: "tipoIdx")
        Prefs.setString(tipo, chave: "tipoString")

        // Buscar os carros pelo tipo selecionado (classico, esportivo, luxo)
        self.buscarCarros()
    }
    
    func atualizar() {
        // Não faz cache, para forçar o web service
        cache = false

        buscarCarros()
    }
    
    func buscarCarros() {

        self.progress.startAnimating()

        let funcaoRetorno = { (carros: Array<Carro>!, error: NSError!) -> Void in

            if(error != nil) {

                Alerta.alerta("Erro: " + error.localizedDescription, viewController: self)

            } else {

                self.carros = carros
                
                // Atualiza o TableView
                self.tableView!.reloadData()
                
                if(Utils.isIpad() && carros.count > 0) {
                    // Seta o primeiro carro na direita
                    let c = carros[0]
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let detalhes = appDelegate.detalhesController!
                    detalhes.updateCarro(c)
                }
            }

            self.progress.stopAnimating()
        }

        CarroService.getCarrosByTipo(tipo, cache:cache, callback:funcaoRetorno)

        // Faz cache da próxima vez
        cache = true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask  {
        if(Utils.isIphone()) {
            // iPhone: Apenas vertical
            return UIInterfaceOrientationMask.Portrait
        } else {
            // iPad: Tudo
            return UIInterfaceOrientationMask.All
        }
    }
}
