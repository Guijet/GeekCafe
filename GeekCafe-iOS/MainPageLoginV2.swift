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
    let fbButton = FBSDKLoginButton()
    
    //Views to animate and build with custom class
    let backgroundView = BackgroundView()
    let firstView = FirstView()
    let secondView = SecondView()
    
    //Page Index for animations
    var pageIndex:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicsSetUp()
        buildBackground()
        buildFirstView()
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
        backgroundView.setUpElements(containerView: self.view)
        self.view.addSubview(backgroundView)
    }
    
    func buildFirstView(){
        fbButton.delegate = self
        firstView.frame = CGRect(x: rw(21), y: rh(320), width: rw(334), height: rh(347))
        firstView.setUpAllElements(containerView: self.view,fbButton:fbButton)
        firstView.addTargetCreateAccount(target:self,action:#selector(inscrirePressed),control:.touchUpInside)
        view.addSubview(firstView)
    }
    
    func buildSecondView(){
        secondView.frame = CGRect(x: rw(21), y: rh(275), width: rw(334), height: rh(392))
        secondView.setUpViews(containerView: self.view)
        secondView.addTargetNextBTN(target: self, selector: #selector(toPage3), event: .touchUpInside)
        view.addSubview(secondView)
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
        buildSecondView()
        firstView.animateOut(containerView:self.view)
        backgroundView.resizeCard(containerView:self.view,newHeight:rh(402),newY:rh(275))
        secondView.animateLeft(containerView: self.view)
        //Get page index for back and go to next page
        pageIndex += 1
    }
    
    func loginPressed(){
        print("Login pressed")
    }

    @objc func toPage3(){
        //ALLER A LA PAGE 3 COMME FAIT AVEC LA 2
    }

}
