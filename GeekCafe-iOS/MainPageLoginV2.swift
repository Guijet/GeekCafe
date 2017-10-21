//
//  MainPageLoginV2.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MainPageLoginV2: UIViewController,FBSDKLoginButtonDelegate{

    //All pages items
    let bgCard = UIView()
    let LBL_Title = UILabel()
    let LBL_Subtitle = UILabel()

    //Arrays of items that will be animated
    var arrayItemsP1 = [UIView]()
    var arrayItemsP2 = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTouchForEndEditing()
        self.view.backgroundColor = Utility().hexStringToUIColor(hex: "#6CA642")
        setUpTranslucentbar()
        setUpTopImage()
        setUpTopLabels()
        buildCard()
        
        
        setUpTextFields()
        setUpButtons()
        createOuLBL()
        setUpFBButton()
        
    }
    
    func updateTextOfTiles(newTitle:String,newSubtitle:String){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.LBL_Title.text = newTitle
            self.LBL_Title.adjustsFontSizeToFitWidth = true
            self.LBL_Subtitle.text = newSubtitle
            self.LBL_Title.frame.origin.y = self.rh(166)
            self.LBL_Subtitle.frame.origin.y = self.LBL_Title.frame.maxY
        }, completion: nil)
        
        
    }
    
    //************************************************
    //
    //
    //
    //
    //PAGE 1
    //
    //
    //
    //
    //************************************************
    func setTouchForEndEditing(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    func setUpTranslucentbar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func setUpTopImage(){
        let logo = UIImageView()
        logo.frame = CGRect(x: rw(135), y: rh(46), width: rw(111), height: rh(106))
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named:"logoLogin")
        self.view.addSubview(logo)
    }
    
    func setUpTopLabels(){
        
        LBL_Title.createLabel(frame: CGRect(x:rw(55),y:rh(197),width:rw(266),height:rh(27)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Bold", fontSize: rw(35), textAignment: .center, text: "Bienvenue")
        self.view.addSubview(LBL_Title)
        
        
        LBL_Subtitle.createLabel(frame: CGRect(x:rw(55),y:LBL_Title.frame.maxY,width:rw(266),height:rh(43)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: "Connectez-nous pour continuer.")
        self.view.addSubview(LBL_Subtitle)
    }
    
    func buildCard(){
        
        bgCard.frame = CGRect(x: rw(21), y: rh(320), width: rw(334), height: rh(352))
        bgCard.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        bgCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 5, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        self.view.addSubview(bgCard)
        
    }
    
    func setUpTextFields(){
        //Email Textfield
        let TB_Email = CustomTextField(placeholderText: "Courriel", containerView: self.view, xPos: rw(52), yPos: rh(358))
        //Password textfield
        let TB_Password = CustomTextField(placeholderText: "Mot de passe", containerView: self.view, xPos: rw(52), yPos: rh(415))
        TB_Password.isSecureTextEntry = true
        arrayItemsP1.append(TB_Email)
        arrayItemsP1.append(TB_Password)
        addCustomTBItemsInArr(arr: &arrayItemsP1, tb: TB_Password)
        addCustomTBItemsInArr(arr: &arrayItemsP1, tb: TB_Email)
    }
    
    func setUpButtons(){
        let ForgetPassword = UIButton()
        ForgetPassword.frame = CGRect(x: rw(203), y: rh(453), width: rw(120), height: rh(25))
        ForgetPassword.setTitle("Mot de passe oublié?", for: .normal)
        ForgetPassword.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        ForgetPassword.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(12))
        ForgetPassword.addTarget(self, action: #selector(forgotPassPressed), for: .touchUpInside)
        self.view.addSubview(ForgetPassword)
        
        
        let inscrireBTN = UIButton()
        inscrireBTN.frame = CGRect(x: rw(55), y: rh(496), width: rw(133), height: rh(48))
        inscrireBTN.backgroundColor = UIColor.white
        inscrireBTN.setTitle("S'inscrire", for: .normal)
        inscrireBTN.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        inscrireBTN.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(16))
        inscrireBTN.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        inscrireBTN.addTarget(self, action: #selector(inscrirePressed), for: .touchUpInside)
        self.view.addSubview(inscrireBTN)
        
        let loginBTN = UIButton()
        loginBTN.createCreateButton(title: "Se connecter", frame: CGRect(x:rw(205),y:rh(494),width:rw(133),height:rh(53)), fontSize: rw(16), containerView: self.view)
        loginBTN.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        loginBTN.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        
        arrayItemsP1.append(ForgetPassword)
        arrayItemsP1.append(inscrireBTN)
        arrayItemsP1.append(loginBTN)
    }
    
    func createOuLBL(){
        let ouLBL = UILabel()
        ouLBL.frame = CGRect(x: rw(20), y: rh(570), width: rw(336), height: rh(19))
        ouLBL.text = "- OU -"
        ouLBL.textAlignment = .center
        ouLBL.font = UIFont(name: "Lato-Bold", size: rw(16))
        ouLBL.textColor = Utility().hexStringToUIColor(hex: "#505050")
        self.view.addSubview(ouLBL)
        arrayItemsP1.append(ouLBL)
    }
    
    func setUpFBButton(){
        let facebookButton = FBSDKLoginButton()
        facebookButton.delegate = self
        facebookButton.frame = CGRect(x: rw(37), y: rh(604), width: rw(301), height: rh(48))
        view.addSubview(facebookButton)
        arrayItemsP1.append(facebookButton)
    }

    //
    //
    //FACEBOOK DELEGATE FUNCTION OR LOGIN BUTTON
    func fetchProfile(){
        let parameters: [String: Any] = ["fields": "email,first_name,last_name,birthday"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                Utility().alert(message: "Error: \(String(describing: error))", title: "Erreur", control: self)
            }
            else{
                if(APIRequestLogin().facebookRequest(accessToken: FBSDKAccessToken.current().tokenString!)){
                    if(APIRequestLogin().viewUser()){
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
                        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            UIApplication.shared.keyWindow?.rootViewController = main
                        }, completion: nil)
                    }
                }
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged Out")
    }
    
    func addCustomTBItemsInArr( arr:inout [UIView],tb:CustomTextField){
        for x in tb.getAllItems(){
            arr.append(x)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        if result.isCancelled{
            print("Cancelled")
        }else{
            fetchProfile()
        }
    }
    
    func forgotPassPressed(){
        print("Forgot password pressed")
    }
    
    func inscrirePressed(){
        print("Inscription pressed")
        buildItemsCardPage2()
        
        //TODO: METTRE UN VRAI IMAGEVIEW EN HAUT AVEC LE BOUTON POUR METTRE LA PHOTO DE PROFIL
        
        updateTextOfTiles(newTitle: "Parlez-nous de vous", newSubtitle: "Complètez votre compte.")
        AnimationsLogin().animateItemsLeft(containerView: self.view, items: arrayItemsP1)
        AnimationsLogin().resizeCard(containerView: self.view, cardView: bgCard, newHeight: rh(402), newYpos: rh(275))
        AnimationsLogin().animateItemsLeft(containerView: self.view, items: arrayItemsP2)
        
    }
    
    func loginPressed(){
        print("Login pressed")
    }
    
    //************************************************
    //
    //
    //
    //
    //PAGE 2
    //
    //
    //
    //
    //************************************************
    func buildItemsCardPage2(){
        let TB_Name = CustomTextField(placeholderText: "Prenom", containerView: self.view, xPos: rw(52) + self.view.frame.width, yPos: rh(308))
        
        let TB_Lastname = CustomTextField(placeholderText: "Nom de famille", containerView: self.view, xPos: rw(52) + self.view.frame.width, yPos: rh(365))
        
        let TB_Birth = CustomTextField(placeholderText: "Date de naissance", containerView: self.view, xPos: rw(52) + self.view.frame.width, yPos: rh(422))
        
        let TB_Password = CustomTextField(placeholderText: "Mot de passe", containerView: self.view, xPos: rw(52) + self.view.frame.width, yPos: rh(479))
        TB_Password.isSecureTextEntry = true
        
        let TB_Confirm = CustomTextField(placeholderText: "Confirmer le mot de passe", containerView: self.view, xPos: rw(52) + self.view.frame.width, yPos: rh(536))
        TB_Confirm.isSecureTextEntry = true
        
        arrayItemsP2.append(TB_Name)
        arrayItemsP2.append(TB_Lastname)
        arrayItemsP2.append(TB_Birth)
        arrayItemsP2.append(TB_Password)
        arrayItemsP2.append(TB_Confirm)
        
        addCustomTBItemsInArr(arr: &arrayItemsP2, tb: TB_Name)
        addCustomTBItemsInArr(arr: &arrayItemsP2, tb: TB_Lastname)
        addCustomTBItemsInArr(arr: &arrayItemsP2, tb: TB_Birth)
        addCustomTBItemsInArr(arr: &arrayItemsP2, tb: TB_Password)
        addCustomTBItemsInArr(arr: &arrayItemsP2, tb: TB_Confirm)
        
        let toPage3BUtton = UIButton()
        toPage3BUtton.frame = CGRect(x: rw(69) + view.frame.width, y: rh(599), width: rw(237), height: rh(45))
        toPage3BUtton.backgroundColor = UIColor.white
        toPage3BUtton.setTitle("S'inscrire", for: .normal)
        toPage3BUtton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        toPage3BUtton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(16))
        toPage3BUtton.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        toPage3BUtton.addTarget(self, action: #selector(toPage3), for: .touchUpInside)
        self.view.addSubview(toPage3BUtton)
        
        arrayItemsP2.append(toPage3BUtton)
    }
    
    func toPage3(){
        //ALLER A LA PAGE 3 COMME FAIT AVEC LA 2
    }

}
