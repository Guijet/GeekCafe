//
//  UtilityLogin.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension UIButton{
    func createCreateButton(title:String,frame:CGRect,fontSize:CGFloat,containerView:UIView){
        //Radent 0.1 a 1.0
        self.frame = frame
        self.setBackgroundImage(UIImage(named:"BackgroundButton"), for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitleColor(Utility().hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        self.titleLabel?.font = UIFont(name: "Lato-Bold", size: fontSize)
        containerView.addSubview(self)
    }
}

extension UIImageView{
    func setUpBackgroundImage(containerView:UIView){
        
        self.frame = CGRect(x: containerView.rw(58), y: containerView.rh(100), width: containerView.rw(390), height: containerView.rw(500))
        self.image = UIImage(named: "LogoBackground")
        self.contentMode = .scaleAspectFit
        
        containerView.addSubview(self)
    }
    
    func setUpImageLogoLogin(frame:CGRect,containerView:UIView){
        
        self.frame = frame
        self.image = UIImage(named: "logoLogin")
        containerView.addSubview(self)
    }
}
extension UIView{
    func rw(_ val: CGFloat) -> CGFloat {
        return val * (self.frame.width / 375)
    }
    func rh(_ val: CGFloat) -> CGFloat {
        return val * (self.frame.height / 667)
    }
}
