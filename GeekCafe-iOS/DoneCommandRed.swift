//
//  DoneCommandeGreen.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-27.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class DoneCommandRed: UIViewController {

    let backgroundImage = UIImageView()
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        //RESET COMMANDE ORDER
        Global.global.itemsOrder.removeAll()
        super.viewDidLoad()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setUpPage()
    }

    func setUpPage(){
        let redCircle = UIImageView()
        redCircle.frame = CGRect(x: rw(131), y: rh(146), width: rw(114), height: rw(114))
        redCircle.image = UIImage(named:"GroupRed")
        view.addSubview(redCircle)
        
        let xImage = UIImageView()
        xImage.frame = CGRect(x: rw(33), y: rh(33), width: rw(49), height: rw(49))
        xImage.image = UIImage(named:"letter-x")
        redCircle.addSubview(xImage)
        
        let redText = UILabel()
        redText.createLabel(frame: CGRect(x:0,y:redCircle.frame.maxY + rh(25),width:view.frame.width,height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "#D0021B"), fontName: "Lato-Regular", fontSize: rw(18), textAignment: .center, text: "VOTRE COMMANDE À ÉCHOUÉE")
        view.addSubview(redText)
        
        let subText = UILabel()
        subText.createLabel(frame: CGRect(x:0,y:redText.frame.maxY + rh(15),width:view.frame.width,height:rh(20)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(18), textAignment: .center, text: "Votre paiement a été refusé")
        view.addSubview(subText)
    }


}
