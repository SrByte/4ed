//
//  DetalhesCarroViewController.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/11/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController, UISplitViewControllerDelegate {

    @IBOutlet var img : DownloadImageView!
    @IBOutlet var tDesc : UITextView!
    
    @IBOutlet var btMapa : UIButton!
    @IBOutlet var btVideo : UIButton!
    
    var carro: Carro?
    
    init() {
        super.init(nibName: "DetalhesCarroViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let c = carro {
            updateCarro(c)

            // Insere o botão na navigation bar
            let btDeletar = UIBarButtonItem(title: "Deletar", style: UIBarButtonItemStyle.Plain, target: self, action: "onClickDeletar")
            self.navigationItem.rightBarButtonItem = btDeletar
        }
    }

    // Copia os valores do carro para a view
    func updateCarro(c: Carro) {

        self.carro = c

        self.title = c.nome

        self.tDesc.text = c.desc;

        self.img.setUrl(c.url_foto)
    }

    // Controlar a troca de orientação (vertical/horizontal)
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

        if(Utils.isIphone()) {
            if(size.width > size.height) {
            print("Horizontal")
            tDesc.hidden = true
            btMapa.hidden = true
            btVideo.hidden = true

            // Horizontal: Esconde tudo
            if((self.tabBarController) != nil) {
                self.tabBarController!.tabBar.hidden = true
            }
            self.navigationController!.navigationBar.hidden = true
        } else {
            print("Vertical")
            
            // Vertical: Mostra tudo
            if((self.tabBarController) != nil) {
                self.tabBarController!.tabBar.hidden = false
            }
            self.navigationController!.navigationBar.hidden = false
            
            tDesc.hidden = false
            btMapa.hidden = false
            btVideo.hidden = false
        }
        
        // Atualiza o status da action bar
        self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func onClickDeletar() {
        let alert = UIAlertController(title: "Confirma?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: {(alert: UIAlertAction) in self.deletar()}))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Destructive, handler: {(alert: UIAlertAction) in }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func deletar() {
        let db = CarroDB()
        db.delete(self.carro!)
        Alerta.alerta("Carro excluído com sucesso.", viewController: self, action:
            { (UIAlertAction) -> Void in
                
                self.goBack()
                
        })
        
    }
    
    func goBack() {
        // Fecha esta tela
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func visualizarMapa(bt: UIButton) {
        let vc = MapViewController()
        vc.carro = self.carro
        if(Utils.isIphone()) {
            // Abre o view controller pelo navigation
            self.navigationController!.pushViewController(vc, animated: true)
        } else {
            print("Mostra no popover")
            
            // Tamanho da janela
            vc.preferredContentSize = CGSize(width: 600, height: 500)
            vc.modalPresentationStyle = UIModalPresentationStyle.Popover;

            // Origem do popover
            let popoverPresentationController = vc.popoverPresentationController
            popoverPresentationController?.sourceView = bt
            
            // Mostra o view controller como popover
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func visualizarVideo(bt: UIButton) {
//        let vc = VideoViewController()
//        vc.carro = self.carro
//        self.navigationController.pushViewController(vc, animated: true)

        let videoUtil = VideoUtil()
        let url = self.carro!.url_foto.url()
        videoUtil.playUrlFullScreen(url, viewController: self)

        
    }
    
    // SplitView
    func splitViewController(svc: UISplitViewController!, wilChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
    
        let vertical = displayMode == UISplitViewControllerDisplayMode.PrimaryHidden;
        
        if(vertical) {
            // Insere o botão na navigation bar
            let btPopover = UIBarButtonItem(title: "Lista", style: UIBarButtonItemStyle.Plain, target: self, action: "onClickPopover")
            self.navigationItem.leftBarButtonItem = btPopover
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
        
    }
    
    func onClickPopover() {
       print("onClickPopover")
        // Mostra o view controller no popover
//        let bt = self.navigationItem.leftBarButtonItem
        let vc = ListaCarrosViewController()
        let popover = UIPopoverController(contentViewController:vc)
        popover.popoverContentSize = CGSize(width: 400, height: 800)
        let rect = CGRect(x:10,y:10,width:10,height:10)
        popover.presentPopoverFromRect(rect,inView:self.view, permittedArrowDirections:UIPopoverArrowDirection.Any, animated:true)
    }
}
















