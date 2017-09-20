//
//  InfoHistory.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class InfoHistory: UIViewController {

    var structToPass:HistoryList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    func setNavigationTitle(){
        self.title = "Info Commande"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"Lato-Regular",size:rw(17))!, NSForegroundColorAttributeName:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
}
