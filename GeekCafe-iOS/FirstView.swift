//
//  FirstView.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-23.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FirstView: UIView {
    
    fileprivate let containerView = UIView()
    fileprivate let ForgetPassword = UIButton()
    fileprivate let inscrireBTN = UIButton()
    fileprivate let loginBTN = UIButton()
    let TB_Pass = CustomTextField()
    let TB_Email = CustomTextField()
    
    func setUpAllElements(superView:UIView,containerView:UIView){
        setElements(containerView: containerView,superView:superView)
        setUpButtons(containerView: containerView)
        setUpLabel(containerView:containerView)
        //placeFBButton(containerView: containerView, fbButton: fbButton)
    }
    
    fileprivate func setElements(containerView:UIView,superView:UIView){
        
        TB_Pass.setUpTB(placeholderText: "Password", containerView: self, xPos: containerView.rw(31), yPos: containerView.rh(95),superView:containerView, heightToGo: superView.rh(248))
        TB_Pass.isSecureTextEntry = true
        
        
        TB_Email.setUpTB(placeholderText: "Email", containerView: self, xPos: containerView.rw(31), yPos: containerView.rh(38),superView:containerView, heightToGo: superView.rh(248))
        
    }
    
    fileprivate func setUpButtons(containerView:UIView){
        
        ForgetPassword.frame = CGRect(x: containerView.rw(184), y: containerView.rh(139), width: containerView.rw(120), height: containerView.rh(25))
        ForgetPassword.setTitle("Mot de passe oublié?", for: .normal)
        ForgetPassword.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        ForgetPassword.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(12))
        //ForgetPassword.addTarget(self, action: #selector(MainPageLoginV2.forgotPassPressed), for: .touchUpInside)
        //self.addSubview(ForgetPassword)
        
        
        
        inscrireBTN.frame = CGRect(x: containerView.rw(27), y: containerView.rh(176), width: containerView.rw(133), height: containerView.rh(48))
        inscrireBTN.backgroundColor = UIColor.white
        inscrireBTN.setTitle("S'inscrire", for: .normal)
        inscrireBTN.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        inscrireBTN.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(16))
        inscrireBTN.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        //inscrireBTN.addTarget(self, action: #selector(MainPageLoginV2.inscrirePressed), for: .touchUpInside)
        self.addSubview(inscrireBTN)
        
        
        loginBTN.createCreateButton(title: "Se connecter", frame: CGRect(x:containerView.rw(177),y:containerView.rh(176),width:containerView.rw(133),height:containerView.rh(53)), fontSize: rw(16), containerView: self)
        loginBTN.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        //loginBTN.addTarget(self, action: #selector(MainPageLoginV2.loginPressed), for: .touchUpInside)
        
    }
    
    fileprivate func setUpLabel(containerView:UIView){
        let ouLBL = UILabel()
        ouLBL.accessibilityIdentifier = "Animatable"
        ouLBL.frame = CGRect(x: 0, y: containerView.rh(249), width: containerView.rw(336), height: containerView.rh(19))
        ouLBL.text = "- OU -"
        ouLBL.textAlignment = .center
        ouLBL.font = UIFont(name: "Lato-Bold", size:rw(16))
        ouLBL.textColor = Utility().hexStringToUIColor(hex: "#505050")
        self.addSubview(ouLBL)
    }
    
//    fileprivate func placeFBButton(containerView:UIView,fbButton:FBSDKLoginButton){
//        fbButton.frame = CGRect(x: containerView.rw(16), y: containerView.rh(284), width:containerView.rw(301), height: containerView.rh(48))
//        self.addSubview(fbButton)
//    }
//    
    
    func addTargetForgetPass(target:Any,action:Selector,control:UIControlEvents){
        ForgetPassword.addTarget(target, action: action, for: control)
    }
    
    func addTargetLogin(target:Any,action:Selector,control:UIControlEvents){
        loginBTN.addTarget(target, action: action, for: control)
    }
    
    func addTargetCreateAccount(target:Any,action:Selector,control:UIControlEvents){
        inscrireBTN.addTarget(target, action: action, for: control)
    }
    
    func animateOut(containerView:UIView){
        AnimationsLogin().animateItemsLeft(containerView: containerView, itemToMove: self)
    }
    
    func getEmailText()->String{
        return TB_Email.text!
    }
    
    func getPasswordText()->String{
        return TB_Pass.text!
    }

}
