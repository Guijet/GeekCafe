//
//  SecondView.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-23.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class SecondView: UIView {

    fileprivate let toPage3BUtton = UIButton()
    
    func setUpViews(containerView:UIView){
        buildView(containerView: containerView)
    }
    
    fileprivate func buildView(containerView:UIView){
        
        let TB_Name = CustomTextField()
        TB_Name.setUpTB(placeholderText: "Prenom", containerView: self, xPos: containerView.rw(31) + containerView.frame.width, yPos: containerView.rh(33),superView:containerView)
        
        let TB_Lastname = CustomTextField()
        TB_Lastname.setUpTB(placeholderText: "Nom de famille", containerView: self, xPos: containerView.rw(31) + containerView.frame.width, yPos: containerView.rh(90),superView:containerView)
        
        let TB_Birth = CustomTextField()
        TB_Birth.setUpTB(placeholderText: "Date de naissance", containerView: self, xPos: containerView.rw(31) + containerView.frame.width, yPos: containerView.rh(147),superView:containerView)
        
        let TB_Password = CustomTextField()
        TB_Password.setUpTB(placeholderText: "Mot de passe", containerView: self, xPos: containerView.rw(31) + containerView.frame.width, yPos: containerView.rh(204),superView:containerView)
        TB_Password.isSecureTextEntry = true
        
        let TB_Confirm = CustomTextField()
        TB_Confirm.setUpTB(placeholderText: "Confirmer le mot de passe", containerView: self, xPos: rw(31) + containerView.frame.width, yPos: containerView.rh(261),superView:containerView)
        TB_Confirm.isSecureTextEntry = true
        
        
        toPage3BUtton.frame = CGRect(x: rw(48) + containerView.frame.width, y: containerView.rh(324), width: containerView.rw(237), height: containerView.rh(45))
        toPage3BUtton.backgroundColor = UIColor.white
        toPage3BUtton.setTitle("S'inscrire", for: .normal)
        toPage3BUtton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        toPage3BUtton.titleLabel?.font = UIFont(name: "Lato-Regular", size: containerView.rw(16))
        toPage3BUtton.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        //toPage3BUtton.addTarget(self, action: #selector(toPage3), for: .touchUpInside)
        self.addSubview(toPage3BUtton)
    }
    
    func fk(){
        
    }
    
    func animateLeft(containerView:UIView){
        AnimationsLogin().animateItemsLeft(containerView: containerView, itemToMove: self)
    }
    
    func addTargetNextBTN(target:Any,selector:Selector,event:UIControlEvents){
        toPage3BUtton.addTarget(target, action: selector, for: event)
    }
        

    
}
