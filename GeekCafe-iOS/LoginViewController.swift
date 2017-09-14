//
//  LoginViewController.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-08-30.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate{

    //Controller variables
    let backgroundImage = UIImageView()
    let imageLogo = UIImageView()
    let TB_Email = UITextField()
    let TB_Password = UITextField()
    let facebookButton = UIButton()
    let createAccountButton = UIButton()
    let connectButton = UIButton()
    let separator = UIView()
    let separator2 = UIView()
    
    //Keyboard
    var isKeyboardActive:Bool = false
    var isGreenButtonActive:Bool = false
    var moveYView:CGFloat = 0
    var moveYButtons:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTranslucentbar()
        buildBackground()
        setUpTop()
        setUpTextBox()
        setUpButton()
        animateIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    func setUpTranslucentbar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    //
    //
    //
    //BUILDING VIEWS
    //
    //
    //
    
    //SetUp Background view IMPORTANT FIXE SIZE FOR ALL PAGE
    func buildBackground(){
        let tapCancelEdit = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapCancelEdit)
        backgroundImage.frame = CGRect(x: rw(58), y: rh(100), width: rw(390), height: rw(500))
        backgroundImage.image = UIImage(named: "LogoBackground")
        backgroundImage.contentMode = .scaleAspectFit
        view.addSubview(backgroundImage)
    }
    
    func setUpTop(){
        imageLogo.frame = CGRect(x: rw(135), y: rw(239), width: rw(105), height: rw(131))
        imageLogo.image = UIImage(named: "logoLogin")
        view.addSubview(imageLogo)
    }
    
    func setUpTextBox(){
        
        TB_Email.delegate = self
        TB_Password.delegate = self
        
        TB_Email.frame = CGRect(x: rw(57), y: rh(302), width: rw(272), height: rh(24))
        TB_Email.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        TB_Email.alpha = 0
        TB_Email.autocorrectionType = .no
        TB_Email.autocapitalizationType = .none
        TB_Email.placeholder = "@username"
        TB_Email.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(20.0))
        TB_Email.textAlignment = .center
        view.addSubview(TB_Email)
        
        separator.frame = CGRect(x: rw(57), y: rh(333), width: rw(272), height: 1)
        separator.alpha = 0
        separator.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
        view.addSubview(separator)
        
        TB_Password.placeholder = "password"
        TB_Password.alpha = 0
        TB_Password.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(20.0))
        TB_Password.isSecureTextEntry = true
        TB_Password.frame = CGRect(x: rw(57), y: rh(354), width: rw(272), height: rh(24))
        TB_Password.textAlignment = .center
        view.addSubview(TB_Password)
        
        separator2.alpha = 0
        separator2.frame = CGRect(x: rw(57), y: rh(385), width: rw(272), height: 1)
        separator2.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
        view.addSubview(separator2)
        
    }
    
    func setUpButton(){
        
        facebookButton.frame = CGRect(x: rw(56), y: rh(562), width: rw(262.5), height: rh(39))
        facebookButton.backgroundColor = Utility().hexStringToUIColor(hex: "#3E549C")
        facebookButton.layer.cornerRadius = rw(10)
        facebookButton.setTitle("Se connecter avec Facebook", for: .normal)
        facebookButton.setTitleColor(Utility().hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        facebookButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: rw(16))
        facebookButton.addTarget(self, action: #selector(fbButtonPressed(sender:)), for: .touchUpInside)
        view.addSubview(facebookButton)
        
        connectButton.isHidden = true
        connectButton.frame = CGRect(x: rw(56), y: rh(562), width: rw(262.5), height: rh(39))
        connectButton.backgroundColor = Utility().hexStringToUIColor(hex: "#6CA743")
        connectButton.layer.cornerRadius = rw(10)
        connectButton.setTitle("Se connecter", for: .normal)
        connectButton.setTitleColor(Utility().hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        connectButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: rw(16))
        connectButton.addTarget(self, action: #selector(connectButtonPressed(sender:)), for: .touchUpInside)
        view.addSubview(connectButton)
        
        createAccountButton.frame = CGRect(x: rw(56), y: rh(613), width: rw(262.5), height: rh(21))
        createAccountButton.setTitle("Créer un compte", for: .normal)
        createAccountButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        createAccountButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(17))
        createAccountButton.addTarget(self, action: #selector(createAccountPressed(sender:)), for: .touchUpInside)
        view.addSubview(createAccountButton)
    }
    
    
    //
    //
    //
    //ANIMATION AND KEYBOARD EVENTS
    //
    //
    //
    
    //Animations when u enter the app to move up
    func animateIn(){
        let topYAnimation = rw(104)
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.imageLogo.center.y -= topYAnimation
            self.TB_Password.alpha = 1
            self.TB_Email.alpha = 1
            self.separator2.alpha = 1
            self.separator.alpha = 1
        },completion: nil)
    }
    
    func moveUp(){
        moveYView = rh(100)
        moveYButtons = rh(140)
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewInSuperViewUp(value: self.moveYView)
            self.createAccountButton.center.y -= self.moveYButtons
            self.connectButton.center.y -= self.moveYButtons
            self.facebookButton.center.y -= self.moveYButtons
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func moveDown(){
        moveYView = rh(100)
        moveYButtons = rh(140)
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewInSuperViewDown(value: self.moveYView)
            self.createAccountButton.center.y += self.moveYButtons
            self.connectButton.center.y += self.moveYButtons
            self.facebookButton.center.y += self.moveYButtons
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    func moveAllViewInSuperViewUp(value:CGFloat){
        for x in self.view.subviews{
            x.center.y -= value
        }
    }
    
    func moveAllViewInSuperViewDown(value:CGFloat){
        for x in self.view.subviews{
            x.center.y += value
        }
    }
    
    func changeToButtonGreen(){
        isGreenButtonActive = true
        connectButton.isHidden = false
        facebookButton.isHidden = true
    }
    
    func changeToFaceBookButton(){
        isGreenButtonActive = false
        connectButton.isHidden = true
        facebookButton.isHidden = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(!isKeyboardActive){
            moveUp()
            isKeyboardActive = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(isKeyboardActive){
            moveDown()
            isKeyboardActive = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    func editingChanged(sender:UITextField){
        if(sender.text == ""){
            if(isGreenButtonActive){
                TB_Password.text = ""
                changeToFaceBookButton()
            }
        }
        else{
            if(!isGreenButtonActive){
                changeToButtonGreen()
            }
        }
    }
    
    
    //
    //
    //
    //BUTTONS EVENTS
    //
    //
    //
    func fbButtonPressed(sender:UIButton){
        print("Facebook")
    }
    

    //When the user connect to the app
    func connectButtonPressed(sender:UIButton){
        if(TB_Email.text! != "" && TB_Password.text! != ""){
            if(APIRequestLogin().login(password: TB_Password.text!, email: TB_Email.text!)){
                if(APIRequestLogin().viewUser()){
                    let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "MainPage")
                    UIApplication.shared.keyWindow?.rootViewController = main
                }
                else{
                    Utility().alert(message: "Impossible de retrouver les informations du compte", title: "Message", control: self)
                }
            }
            else{
                Utility().alert(message: "Nom d'utilisateur ou mot de passe invalide", title: "Message", control: self)
            }
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs", title: "Message", control: self)
        }
    }
    
    func createAccountPressed(sender:UIButton){
        performSegue(withIdentifier: "toCreateAccount", sender: nil)
    }
    
}


