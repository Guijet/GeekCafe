//
//  DoneCommandeRed.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-27.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class DoneCommandGreen: UIViewController {

    let backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        Global.global.itemsOrder.removeAll()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setUpPage()
    }
    
    
    func setUpPage(){
        let greenCircle = UIImageView()
        greenCircle.frame = CGRect(x: rw(131), y: rh(146), width: rw(114), height: rw(114))
        greenCircle.image = UIImage(named:"CircleGreen")
        view.addSubview(greenCircle)
        
        let grayText = UILabel()
        grayText.createLabel(frame: CGRect(x:0,y:greenCircle.frame.maxY + rh(19),width:view.frame.width,height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(18), textAignment: .center, text: "VOTRE COMMANDE".uppercased())
        view.addSubview(grayText)
        
        let greenText = UILabel()
        greenText.createLabel(frame: CGRect(x:0,y:grayText.frame.maxY,width:view.frame.width,height:rh(40)), textColor: Utility().hexStringToUIColor(hex: "#16E9A6"), fontName: "Lato-Regular", fontSize: rw(35), textAignment: .center, text: "EST CONFIRMÉE".uppercased())
        view.addSubview(greenText)
        
        let toChronoButton = UIButton()
        toChronoButton.createCreateButton(title: "Accepter", frame: CGRect(x:view.frame.midX - rw(100),y:rh(555),width:rw(200),height:rh(60)), fontSize: rw(22), containerView: self.view)
        toChronoButton.addTarget(self, action: #selector(toChrono), for: .touchUpInside)
    }
    
    @objc func toChrono(){
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.keyWindow?.rootViewController = main
        }, completion: nil)
    }
}
