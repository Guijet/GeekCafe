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
    
    //Facebook button
    //let fbButton = FBSDKLoginButton()
    let loading = loadingIndicator()
    let labelFB = UILabel()
    
    //Views to animate and build with custom class
    let backgroundView = BackgroundView()
    let firstView = FirstView()
    var isFromFB:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicsSetUp()
        buildBackground()
        buildFirstView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(!isFromFB){
            UserDefaults.standard.synchronize()
            if let tokenTB = UserDefaults.standard.object(forKey: "FB_Token") as? String{
                autoLoginFB(access_token: tokenTB)
            }
            else if let token = UserDefaults.standard.object(forKey: "Token") as? String{
                autoLogin(token: token)
            }
        }
    }
    //
    //
    //PAGE BASICS
    //
    //
    func setTouchForEndEditing(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    func setUpTranslucentbar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func basicsSetUp(){
        setTouchForEndEditing()
        self.view.backgroundColor = Utility().hexStringToUIColor(hex: "#6CA642")
        setUpTranslucentbar()
    }
    
    func buildBackground(){
        backgroundView.frame = self.view.frame
        backgroundView.setUpElements(containerView: self.view, frameImageTop: CGRect(x: rw(132), y: rh(80), width: rw(111), height: rh(106)), frameFirstLabel: CGRect(x:rw(55),y:rh(197),width:rw(266),height:rh(27)), frameCard: CGRect(x: rw(21), y: rh(320), width: rw(334), height: rh(352)), text1: "Bienvenue",text2:"Connectez-nous pour continuer.")
        
        self.view.addSubview(backgroundView)
    }
    
    func buildFirstView(){
        //fbButton.delegate = self
        firstView.frame = CGRect(x: rw(21), y: rh(320), width: rw(334), height: rh(347))
        firstView.setUpAllElements(superView: self.view, containerView: self.view)
        firstView.addTargetCreateAccount(target:self,action:#selector(inscrirePressed),control:.touchUpInside)
        firstView.addTargetLogin(target: self, action: #selector(connectPressed), control: .touchUpInside)
        view.addSubview(firstView)
        
        let customFBButton = UIButton()
        customFBButton.frame = CGRect(x: rw(37), y: rh(604), width: rw(301), height: rh(48))
        customFBButton.backgroundColor = Utility().hexStringToUIColor(hex: "#3C6499")
        customFBButton.addTarget(self, action: #selector(loginFacebookAction), for: .touchUpInside)
        
        let fbIMage = UIImageView()
        fbIMage.frame = CGRect(x: rw(31), y: rh(14), width: rw(23), height: rw(23))
        fbIMage.image = UIImage(named:"fb_ButtonIMG")
        fbIMage.contentMode = .scaleAspectFit
        customFBButton.addSubview(fbIMage)
        
        Utility().createVerticalHR(x: rw(72), y: rh(10), height: rh(30), view: customFBButton, color: UIColor.white)
        
        labelFB.createLabel(frame: CGRect(x:rw(72),y:rh(16),width:rw(225),height:rh(16)), textColor: UIColor.white, fontName: "Lato-Bold", fontSize: rw(13), textAignment: .center, text: "Connexion avec Facebook")
        customFBButton.addSubview(labelFB)
        view.addSubview(customFBButton)
    }
    
    
    //
    //
    //FACEBOOK DELEGATE FUNCTION OR LOGIN BUTTON
    @objc func fetchProfile(){
        let parameters: [String: Any] = ["fields": "email,first_name,last_name,birthday"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                Utility().alert(message: "Error: \(String(describing: error))", title: "Erreur", control: self)
            }
            else{
                if(APIRequestLogin().facebookRequest(accessToken: FBSDKAccessToken.current().tokenString!)){
                    if(APIRequestLogin().viewUser()){
                        Global.global.isFbUser = true
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
    
    @IBAction func loginFacebookAction(sender: AnyObject) {
        isFromFB = true
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.fetchProfile()
                }
            }
        }
    }
    
    
    //
    //FB Did logout with fb button
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged Out")
    }
    
   
    //
    //FB did login with fb button
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
    
    //
    //Forgot passsword pressed
    func forgotPassPressed(){
        print("Forgot password pressed")
    }
    
    //
    //Create account pressed 
    @objc func inscrirePressed(){
        performSegue(withIdentifier: "toSignUpV2_1", sender: nil)
    }
    
    //
    //
    //AUTO LOGIN
    //
    //
    func autoLogin(token:String){
        self.loading.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos:.background).async {
            if(APIRequestLogin().verifyToken(token: token)){
                if(APIRequestLogin().viewUser()){
                    Global.global.userInfo.cards = APIRequestLogin().indexPaymentsMethod(cardHolderName: "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)")
                    DispatchQueue.main.async {
                        self.loading.stopAnimatingAndRemove(view: self.view)
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
                        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            UIApplication.shared.keyWindow?.rootViewController = main
                        }, completion: nil)
                    }
                }
            }
        }
    }
    
    func autoLoginFB(access_token:String){
        self.loading.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos:.background).async {
            if(APIRequestLogin().getTokenWithFB(access_token: access_token)){
                if(APIRequestLogin().viewUser()){
                    Global.global.isFbUser = true
                    Global.global.userInfo.cards = APIRequestLogin().indexPaymentsMethod(cardHolderName: "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)")
                    DispatchQueue.main.async {
                        self.loading.stopAnimatingAndRemove(view: self.view)
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
                        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            UIApplication.shared.keyWindow?.rootViewController = main
                        }, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func connectPressed(){
        self.endEditing()
        self.loading.buildViewAndStartAnimate(view: self.view)
        if(firstView.getEmailText() != "" && firstView.getPasswordText() != ""){
            DispatchQueue.global(qos:.background).async {
                if(APIRequestLogin().login(password: self.firstView.getPasswordText(), email: self.firstView.getEmailText())){
                    if(APIRequestLogin().viewUser()){
                        DispatchQueue.main.async {
                            self.loading.stopAnimatingAndRemove(view: self.view)
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
                            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                UIApplication.shared.keyWindow?.rootViewController = main
                            }, completion: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.loading.stopAnimatingAndRemove(view: self.view)
                            Utility().alert(message: "Impossible de retrouver les informations du compte", title: "Message", control: self)
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.loading.stopAnimatingAndRemove(view: self.view)
                        Utility().alert(message: "Nom d'utilisateur ou mot de passe invalide", title: "Message", control: self)
                    }
                }
            }
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs", title: "Message", control: self)
        }
    }
}
