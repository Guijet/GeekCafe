//
//  SignUp4.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//


//WAIT FOR MATHIEU FOR NEW DESIGN

import UIKit
import AVFoundation

class SignUp4: UIViewController,UITextFieldDelegate,CardIOViewDelegate{

    var arrayPlaceholders = ["Numéro de carte crédit","Date d'expiration","CVC"]
    let TB_CreditNumber = UITextField()
    let TB_Exiraprion = UITextField()
    let TB_CVC = UITextField()
    var arrayTextField = [UITextField]()
    
    let cardIOView = CardIOView()
    let cameraCardButton = UIButton()
    let backgroundImage = UIImageView()
    let imageLogo = UIImageView()
    let nextButton = UIButton()
    
    var isKeyBoardActive:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ask for camera usage
        buildBackground()
        setUpTop()
        setUpTextFields()
        setUpButtonCamera()
        setUpButton()
    }

    //Background image
    func buildBackground(){
        let tapCancelEditing = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapCancelEditing)
        backgroundImage.setUpBackgroundImage(containerView: self.view)
    }
    
    //Image Geek Cafe Top
    func setUpTop(){
        imageLogo.setUpImageLogoLogin(frame:CGRect(x: rw(135), y: rw(39), width: rw(105), height: rw(131)),containerView:self.view)
    }
    
    //TextFields
    func setUpTextFields(){
        arrayTextField = [TB_CreditNumber,TB_Exiraprion,TB_CVC]
        var index = 0
        var yTo:CGFloat = rh(239)
        
        for x in arrayTextField{
            x.delegate = self
            x.frame = CGRect(x: rw(57.5), y: yTo, width: rw(272), height: 34)
            x.placeholder = arrayPlaceholders[index]
            x.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(20.0))
            x.textAlignment = .center
            x.autocorrectionType = .no
            x.autocapitalizationType = .none
            view.addSubview(x)
            
            let separator = UIView()
            separator.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
            separator.frame = CGRect(x: rw(57.5), y: x.frame.maxY + rh(7), width: rw(272), height: 1)
            view.addSubview(separator)
            yTo += rh(60)
            index += 1
        }
    }
    
    func setUpButtonCamera(){
        cameraCardButton.frame = CGRect(x: rw(50), y: rh(420), width: view.frame.width - rw(100), height: rh(21))
        cameraCardButton.setTitle("Créer un compte", for: .normal)
        cameraCardButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        cameraCardButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(17))
        cameraCardButton.addTarget(self, action: #selector(showCardIOCamera(sender:)), for: .touchUpInside)
        view.addSubview(cameraCardButton)
    }
    
    //Bottom Button
    func setUpButton(){
        
        nextButton.createCreateButton(title: "Suivant", frame: CGRect(x: rw(88), y: rh(553), width: rw(200), height: rh(50)),fontSize:rw(20),containerView:self.view)
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        
    }
    
    func endEditing(){
        self.view.endEditing(true)
    }
    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        
    }
    func showCardIOCamera(sender:UIButton){
        //Camera
        cardIOView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        cardIOView.delegate = self
        self.view.addSubview(cardIOView)

    }
    
    func nextPressed(sender:UIButton){
        performSegue(withIdentifier: "toCardInfo", sender: nil)
    }
}
