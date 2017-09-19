//
//  HistoriqueList.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class HistoriqueList: UIViewController {

    let menu = MenuClass()
    let containerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Historique")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
}
