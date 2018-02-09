//
//  TermsAndCondition.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class TermsAndCondition: UIViewController,UIWebViewDelegate {
    
    var webView:UIWebView!
    let loadingView = loadingIndicator()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setUpWebView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Termes et conditions"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpWebView(){
        webView = UIWebView(frame: self.view.frame)
        webView.delegate = self
        view.addSubview(webView)
        loadingView.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos:.background).async {
            if let url = URL(string: "http://apple.com") {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    self.webView.loadRequest(request)
                    self.loadingView.stopAnimatingAndRemove(view: self.view)
                }
            }
        }
    }

}
