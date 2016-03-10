//
//  SobreViewController.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/11/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

let URL_SOBRE = "http://www.livroiphone.com.br/carros/sobre.htm"

/**
Sobre este erro:

App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.

http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http

NSAllowsArbitraryLoads to YES

**/
class SobreViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView : UIWebView!
    @IBOutlet var progress : UIActivityIndicatorView!
    
    init() {
        super.init(nibName: "SobreViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Título
        self.title = "Sobre"
        
        // Inicia a animação do activity indicator
        self.progress.startAnimating()
        
        // Carrega a URL no WebView
        let url = NSURL(string: URL_SOBRE)!
        
        //let path = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        //let url = NSURL(fileURLWithPath:path!)!

        let request = NSURLRequest(URL:url,cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 0)
        self.webView.loadRequest(request)

        // delegate
        self.webView.delegate = self
        
        print("go")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        progress.stopAnimating()
        print("stop")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("Carregando página \(request.URL)!")
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask  {
        // Apenas vertical
        return UIInterfaceOrientationMask.Portrait
    }
    
    
}
