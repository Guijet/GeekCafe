//
//  SignUp3.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class SignUp3: UIViewController,UITextFieldDelegate{

    var arrayPlaceholders = ["Mot de passe","Vérifier mot de passe"]
    let TB_Password = UITextField()
    let TB_Confirm = UITextField()
    var arrayTextField = [UITextField]()
    var arraySeparator = [UIView]()
    
    let backgroundImage = UIImageView()
    let imageLogo = UIImageView()
    let nextButton = UIButton()
    var isKeyBoardActive:Bool = false
    
    var firstName:String!
    var lastName:String!
    var sexe:String!
    var birthdate:String!
    var phone:String!
    var email:String!
    var password:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildBackground()
        setUpTop()
        setUpTextFields()
        setUpButton()
        // Do any additional setup after loading the view.
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
        arrayTextField = [TB_Password,TB_Confirm]
        var index = 0
        var yTo:CGFloat = rh(287)
        
        for x in arrayTextField{
            x.delegate = self
            x.isSecureTextEntry = true
            x.frame = CGRect(x: rw(57.5), y: yTo, width: rw(272), height: 34)
            x.placeholder = arrayPlaceholders[index]
            x.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(20.0))
            x.textAlignment = .center
            view.addSubview(x)
            
            let separator = UIView()
            separator.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
            separator.frame = CGRect(x: rw(57.5), y: x.frame.maxY + rh(7), width: rw(272), height: 1)
            view.addSubview(separator)
            arraySeparator.append(separator)
            yTo += rh(60)
            index += 1
        }
    }
    
    //Bottom Button
    func setUpButton(){
        
        nextButton.createCreateButton(title: "Suivant", frame: CGRect(x: rw(88), y: rh(553), width: rw(200), height: rh(50)),fontSize:rw(20),containerView:self.view)
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        
    }
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    
    //
    //
    //TEXTFIELD DELEGATES METHOD
    //
    //
    func animateUp(){
        let valueTB:CGFloat = rh(45)
        let value:CGFloat = rh(160)
        let valueBtnY:CGFloat = rh(100)
        let buttonMove:CGFloat = rh(35)
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewsUp(value: value)
            self.nextButton.center.y -= valueBtnY
            self.imageLogo.center.y -= buttonMove
            self.arrayTextField[0].center.y -= valueTB
            self.arrayTextField[1].center.y -= valueTB
            self.arraySeparator[0].center.y -= valueTB
            self.arraySeparator[1].center.y -= valueTB
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func animateDown(){
        let valueTB:CGFloat = rh(45)
        let value:CGFloat = rh(160)
        let valueBtnY:CGFloat = rh(100)
        let buttonMove:CGFloat = rh(35)
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewsDown(value: value)
            self.nextButton.center.y += valueBtnY
            self.imageLogo.center.y += buttonMove
            self.arrayTextField[0].center.y += valueTB
            self.arrayTextField[1].center.y += valueTB
            self.arraySeparator[0].center.y += valueTB
            self.arraySeparator[1].center.y += valueTB
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func moveAllViewsUp(value:CGFloat){
        for x in self.view.subviews{
            x.center.y -= value
        }
    }
    func moveAllViewsDown(value:CGFloat){
        for x in self.view.subviews{
            x.center.y += value
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(!isKeyBoardActive){
            animateUp()
            isKeyBoardActive = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(isKeyBoardActive){
            animateDown()
            isKeyBoardActive = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //
    //
    //
    //EVENTS FOR NEXT PAGE
    //
    //
    //
    func nextPressed(sender:UIButton){
        endEditing()
        if(TB_Password.text! != "" && TB_Confirm.text! != ""){
            if(TB_Confirm.text! == TB_Password.text!){
                if((TB_Password.text?.characters.count)! >= 7){
                    password = TB_Password.text!
                    performSegue(withIdentifier: "toCardInformation", sender: nil)
                }
                else{
                    Utility().alert(message: "Le mot de passe doit contenir au moins 7 caractères.", title: "Message", control: self)
                }
                
            }
            else{
                Utility().alert(message: "Les mot de passe ne correspond pas à la confirmation", title: "Message", control: self)
            }
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs", title: "Message", control: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toCardInformation"){
            (segue.destination as! SignUp4).firstName = self.firstName
            (segue.destination as! SignUp4).lastName = self.lastName
            (segue.destination as! SignUp4).sexe = self.sexe
            (segue.destination as! SignUp4).birthdate = self.birthdate
            (segue.destination as! SignUp4).phone = self.phone
            (segue.destination as! SignUp4).email = self.email
            (segue.destination as! SignUp4).password = self.password
        }
    }

}
