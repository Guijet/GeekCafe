//
//  RateMyApp.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class RateMyApp: UIViewController,UIWebViewDelegate{

    var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setUpWebView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Rating"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpWebView(){
        webView = UIWebView(frame: self.view.frame)
        webView.delegate = self
        view.addSubview(webView)
        if let url = URL(string: "http://apple.com") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }


}
