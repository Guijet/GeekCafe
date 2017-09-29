//
//  SignUp2.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class SignUp2: UIViewController,UITextFieldDelegate{
    var arrayPlaceholders = ["Téléphone","Courriel"]
    let TB_Telephone = UITextField()
    let TB_Email = UITextField()
    var arrayTextField = [UITextField]()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildBackground()
        setUpTop()
        setUpTextFields()
        setUpButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
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
        arrayTextField = [TB_Telephone,TB_Email]
        var index = 0
        var yTo:CGFloat = rh(239)
        
        for x in arrayTextField{
            x.delegate = self
            x.autocorrectionType = .no
            x.autocapitalizationType = .none
            x.frame = CGRect(x: rw(57.5), y: yTo, width: rw(272), height: 34)
            x.placeholder = arrayPlaceholders[index]
            x.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(20.0))
            x.textAlignment = .center
            view.addSubview(x)
            
            let separator = UIView()
            separator.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
            separator.frame = CGRect(x: rw(57.5), y: x.frame.maxY + rh(7), width: rw(272), height: 1)
            view.addSubview(separator)
            
            yTo += rh(60)
            index += 1
        }
        arrayTextField[0].keyboardType = .numberPad
        arrayTextField[1].keyboardType = .emailAddress
    }
    
    //Bottom Button
    func setUpButton(){
        
        nextButton.createCreateButton(title: "Suivant", frame: CGRect(x: rw(87), y: rh(561), width: rw(202), height: rh(50)),fontSize:rw(20),containerView:self.view)
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)

    }
    
    //
    //
    //TEXTFIELD DELEGATES METHOD
    //
    //
    func animateUp(){
        let value:CGFloat = rh(160)
        let valueBtnY:CGFloat = rh(100)
        let buttonMove:CGFloat = rh(35)
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewsUp(value: value)
            self.nextButton.center.y -= valueBtnY
            self.imageLogo.center.y -= buttonMove
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func animateDown(){
        let value:CGFloat = rh(160)
        let valueBtnY:CGFloat = rh(100)
        let buttonMove:CGFloat = rh(35)
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewsDown(value: value)
            self.nextButton.center.y += valueBtnY
            self.imageLogo.center.y += buttonMove
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
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    //
    //EVENT ON CLICK NEXT
    //
    func nextPressed(sender:UIButton){
        endEditing()
        if(TB_Email.text! != "" && TB_Telephone.text != ""){
            if(APIRequestLogin().verifyEmail(email: TB_Email.text!)){
                phone = TB_Telephone.text!
                email = TB_Email.text!
                performSegue(withIdentifier: "toSignUp3", sender: nil)
            }
            else{
                Utility().alert(message: "This email is already being used!", title: "Message", control: self)
            }
            
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs", title: "Message", control: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSignUp3"){
            (segue.destination as! SignUp3).firstName = self.firstName
            (segue.destination as! SignUp3).lastName = self.lastName
            (segue.destination as! SignUp3).sexe = self.sexe
            (segue.destination as! SignUp3).birthdate = self.birthdate
            (segue.destination as! SignUp3).phone = self.phone
            (segue.destination as! SignUp3).email = self.email
        }
    }
}
