//
//  MainPageLoginV2.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class MainPageLoginV2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Utility().hexStringToUIColor(hex: "#6CA642")
        setUpTranslucentbar()
        setUpTopLabels()
        buildCard()
        
    }
    
    func setUpTranslucentbar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func setUpTopLabels(){
        let LBL_BienvenueD = UILabel()
        LBL_BienvenueD.createLabel(frame: CGRect(x:rw(55),y:rh(197),width:rw(266),height:rh(27)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Bold", fontSize: rw(35), textAignment: .center, text: "Bienvenue")
        self.view.addSubview(LBL_BienvenueD)
        
        let LBL_ConnecterD = UILabel()
        LBL_ConnecterD.createLabel(frame: CGRect(x:rw(55),y:LBL_BienvenueD.frame.maxY,width:rw(266),height:rh(43)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: "Connectez-nous pour continuer.")
        self.view.addSubview(LBL_ConnecterD)
    }
    
    func buildCard(){
        let bgCard = UIView()
        bgCard.frame = CGRect(x: rw(21), y: rh(320), width: rw(334), height: rh(352))
        bgCard.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        bgCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 5, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        self.view.addSubview(bgCard)
        
    }


}
