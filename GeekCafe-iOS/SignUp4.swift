//
//  SignUp4.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//


//WAIT FOR MATHIEU FOR NEW DESIGN

import UIKit
import Stripe
import AFNetworking
import AVFoundation

class SignUp4: UIViewController,UITextFieldDelegate,CardIOViewDelegate{

    let contentViewIO = UIView()
    let cardIOView = CardIOView()
    let backgroundImage = UIImageView()
    let TB_CardNumber = UITextField()
    let TB_Expiration = UITextField()
    let TB_CardHolderName = UITextField()
    let TB_CVC = UITextField()
    let nextButton = UIButton()
    var cardToken:String!
    
    let load = loadingIndicator()
    
    var isKeyBoardActive:Bool = false
    
    //User info
    var firstName:String!
    var lastName:String!
    var sexe:String!
    var birthdate:String!
    var phone:String!
    var email:String!
    var password:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ask for camera usage
        buildBackground()
        buildTopCard()
        setUpButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        TB_CardNumber.becomeFirstResponder()
    }
    
    //Background image
    func buildBackground(){
        backgroundImage.setUpBackgroundImage(containerView: self.view)
    }
    
    func buildTopCard(){
        let topCard = UIImageView()
        topCard.frame = CGRect(x: rw(28), y: rh(76), width: rw(319), height: rh(172))
        topCard.image = UIImage(named: "CardRectangle")
        view.addSubview(topCard)
        
        let labelCardNumber = UILabel()
        labelCardNumber.frame = CGRect(x: rw(42), y: rh(112), width: rw(84), height: rh(11))
        labelCardNumber.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        labelCardNumber.font = UIFont(name: "Lato-Bold", size: rw(9))
        labelCardNumber.textAlignment = .left
        labelCardNumber.text = "CARD NUMBER".uppercased()
        view.addSubview(labelCardNumber)
        
        let cameraButton = UIButton()
        cameraButton.frame = CGRect(x: rw(130), y: rh(105), width: rw(25), height: rw(25))
        cameraButton.setImage(UIImage(named:"CameraButton"), for: .normal)
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 4, right: 3)
        cameraButton.addTarget(self, action: #selector(showCardIOView(sender:)), for: .touchUpInside)
        view.addSubview(cameraButton)
        
        TB_CardNumber.delegate = self
        TB_CardNumber.autocorrectionType = .no
        TB_CardNumber.keyboardType = .numberPad
        TB_CardNumber.frame = CGRect(x: rw(165), y: rh(108), width: rh(168), height: rh(17))
        TB_CardNumber.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_CardNumber.placeholder = "Numéro de carte"
        TB_CardNumber.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(14))
        TB_CardNumber.font = UIFont(name: "Lato-Regular", size: rw(15))
        TB_CardNumber.textAlignment = .right
        view.addSubview(TB_CardNumber)
        
        Utility().createHR(x: rw(42), y: rh(132), width: rw(291), view: self.view, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        
        let expirationDate = UILabel()
        expirationDate.frame = CGRect(x: rw(42), y: rh(162), width: rw(87), height: rh(11))
        expirationDate.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        expirationDate.font = UIFont(name: "Lato-Bold", size: rw(9))
        expirationDate.textAlignment = .left
        expirationDate.text = "EXPIRATION DATE".uppercased()
        view.addSubview(expirationDate)
        
        TB_Expiration.delegate = self
        TB_Expiration.autocorrectionType = .no
        TB_Expiration.keyboardType = .numberPad
        TB_Expiration.frame = CGRect(x: rw(151), y: rh(157), width: rh(70), height: rh(17))
        TB_Expiration.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_Expiration.font = UIFont(name: "Lato-Regular", size: rw(14))
        TB_Expiration.placeholder = "Expiration"
        TB_Expiration.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(14))
        TB_Expiration.textAlignment = .right
        view.addSubview(TB_Expiration)
        
        let labelCVC = UILabel()
        labelCVC.frame = CGRect(x: rw(245), y: rh(162), width: rw(23), height: rh(17))
        labelCVC.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        labelCVC.font = UIFont(name: "Lato-Bold", size: rw(9))
        labelCVC.textAlignment = .left
        labelCVC.text = "CVC".uppercased()
        view.addSubview(labelCVC)
        
        TB_CVC.delegate = self
        TB_CVC.autocorrectionType = .no
        TB_CVC.keyboardType = .numberPad
        TB_CVC.frame = CGRect(x: rw(297), y: rh(157), width: rh(36), height: rh(17))
        TB_CVC.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_CVC.placeholder = "CVC"
        TB_CVC.font = UIFont(name: "Lato-Regular", size: rw(14))
        TB_CVC.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(12))
        TB_CVC.textAlignment = .right
        view.addSubview(TB_CVC)
        
        Utility().createHR(x: rw(42), y: rh(178), width: rw(180), view: self.view, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        Utility().createHR(x: rw(245), y: rh(178), width: rw(88), view: self.view, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        let labelCardHolder = UILabel()
        labelCardHolder.frame = CGRect(x: rw(42), y: rh(208), width: rw(100), height: rh(11))
        labelCardHolder.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        labelCardHolder.font = UIFont(name: "Lato-Bold", size: rw(9))
        labelCardHolder.textAlignment = .left
        labelCardHolder.text = "CARDHOLDER NAME".uppercased()
        view.addSubview(labelCardHolder)
        
        TB_CardHolderName.delegate = self
        TB_CardHolderName.autocorrectionType = .no
        TB_CardHolderName.frame = CGRect(x: rw(153), y: rh(205), width: rh(180), height: rh(17))
        TB_CardHolderName.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_CardHolderName.placeholder = "Card Holder Name"
        TB_CardHolderName.font = UIFont(name: "Lato-Regular", size: rw(14))
        TB_CardHolderName.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(12))
        TB_CardHolderName.textAlignment = .right
        view.addSubview(TB_CardHolderName)
        
        Utility().createHR(x: rw(42), y: rh(225), width: rw(291), view: self.view, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
    }

    
    //Bottom Button
    func setUpButton(){
        
        nextButton.createCreateButton(title: "Terminer", frame: CGRect(x: rw(87), y: rh(280), width: rw(202), height: rh(50)),fontSize:rw(20),containerView:self.view)
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        
        let noCardButton = UIButton()
        noCardButton.frame = CGRect(x: rw(104), y: rh(350), width: rw(168), height: rh(25))
        noCardButton.setTitle("Pas de carte", for: .normal)
        noCardButton.setTitleColor(Utility().hexStringToUIColor(hex: "#DCDCDC"), for: .normal)
        noCardButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(20))
        noCardButton.addTarget(self, action: #selector(nextNoCard(sender:)), for: .touchUpInside)
        view.addSubview(noCardButton)
    }
    
    
    
    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        TB_CardNumber.text = splitCardNumberWithSpace(number:cardInfo.cardNumber)
        TB_Expiration.text = "\(cardInfo.expiryMonth) / \(cardInfo.expiryYear)"
        TB_CardHolderName.text = cardInfo.cardholderName
        removeViewIO()
    }
    
    func showCardIOView(sender:UIButton){
        endEditing()
        self.navigationController?.navigationBar.isHidden = true
        contentViewIO.frame = view.frame
        contentViewIO.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(contentViewIO)
        
        cardIOView.delegate = self
        cardIOView.hideCardIOLogo = true
        cardIOView.languageOrLocale = "fr"
        
        cardIOView.frame = CGRect(x: rw(30), y: (view.frame.height - rh(400))/2, width: view.frame.width - rw(60), height: rh(400))
        contentViewIO.addSubview(cardIOView)
        
        let cancelButton = UIButton()
        
        cancelButton.frame = CGRect(x: cardIOView.frame.maxX - rw(20), y: cardIOView.frame.minY - rw(20), width: rw(40), height: rw(40))
        cancelButton.setImage(UIImage(named:"close_IO"), for: .normal)
        cancelButton.addTarget(self, action: #selector(removeViewIO), for: .touchUpInside)
        contentViewIO.addSubview(cancelButton)
        
    }
    
    func removeViewIO(){
        TB_CardNumber.becomeFirstResponder()
        self.navigationController?.navigationBar.isHidden = false
        contentViewIO.removeFromSuperview()
    }
    
    
    
    func getCardToken(cardNumber:String,cvv:String,expiryMonth:String,expiryYear:String){
        do {
            
            let stripCard = STPCard()
            stripCard.number = cardNumber
            stripCard.cvc = cvv
            stripCard.expMonth = UInt(expiryMonth)!
            stripCard.expYear = UInt("20\(expiryYear)")!
            
            try stripCard.validateReturningError()
            STPAPIClient().createToken(with: stripCard, completion: { (token, error) -> Void in
                if error == nil {
                    
                    if(APIRequestLogin().createAcount(first_name: self.firstName, last_name: self.lastName, gender: self.sexe, birth_date: self.birthdate, phone: self.phone, email: self.email, password: self.password)){
                        if(APIRequestLogin().addPaymentMethod(card_token:token!.tokenId)){
                            DispatchQueue.main.async {
                                self.load.stopAnimatingAndRemove(view: self.view)
                            }
                            Global.global.userInfo.cards = APIRequestLogin().indexPaymentsMethod(cardHolderName: self.TB_CardHolderName.text!)
                            self.performSegue(withIdentifier: "toCardInfo", sender: nil)
                        }
                        else{
                            DispatchQueue.main.async {
                                self.load.stopAnimatingAndRemove(view: self.view)
                            }
                            Utility().alert(message: "Erreur avec la carte entrer", title: "Erreur", control: self)
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.load.stopAnimatingAndRemove(view: self.view)
                    }
                    Utility().alert(message: "Erreur lors de la création de compte.", title: "Erreur", control: self)
                }
            })
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if(textField == TB_Expiration){
            let lenght = textField.text?.characters.count
            if(lenght! == 2){
                if (isBackSpace != -92) {
                    TB_Expiration.text?.append("/")
                }
            }
            if(lenght! > 4){
                if (isBackSpace != -92) {
                    return false
                }
            }
        }
        
        if(textField == TB_CVC){
            let lenght = textField.text?.characters.count
            if(lenght! > 2){
                if (isBackSpace != -92) {
                    return false
                }
            }
        }
        
        if(textField == TB_CardNumber){
            let lenght = textField.text?.characters.count
            if (isBackSpace != -92) {
                if(lenght == 4 || lenght == 9 || lenght == 14){
                    textField.text?.append(" ")
                }
            }
            if(lenght! > 18){
                if (isBackSpace != -92) {
                    return false
                }
            }
        }

        return true
    }

    
    func splitCardNumberWithSpace(number:String)->String{
        var index:Int = 0
        var splitNumber:String = ""
        for x in number.characters{
            splitNumber.append(x)
            if(index == 3){
                splitNumber.append(" ")
                index = 0
            }
            else{
                index += 1
            }
        }
        return splitNumber
    }
    
    func nextPressed(sender:UIButton){
        
        load.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos: .background).async {
            if(!(self.TB_CardNumber.text?.isEmpty)! && !(self.TB_Expiration.text?.isEmpty)! && !(self.TB_CVC.text?.isEmpty)! && !(self.TB_CardHolderName.text?.isEmpty)!){
                self.getCardToken(cardNumber: self.TB_CardNumber.text!.components(separatedBy: .whitespaces).joined(), cvv: self.TB_CVC.text!, expiryMonth: self.splitExpiration(expiration: self.TB_Expiration.text!)[0], expiryYear: self.splitExpiration(expiration: self.TB_Expiration.text!)[1])
            }
            else{
                Utility().alert(message: "Vous devez remplir tout les champs.", title: "Message", control: self)
            }
            
        }
        
    }
    
    func nextNoCard(sender:UIButton){
        if(APIRequestLogin().createAcount(first_name: firstName, last_name: lastName, gender: sexe, birth_date: birthdate, phone: phone, email: email, password: password)){
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                UIApplication.shared.keyWindow?.rootViewController = main
            }, completion: nil)
        }
    }
    
    func splitExpiration(expiration:String)->[String]{
        let arrayString = expiration.components(separatedBy: "/")
        return [arrayString[0],arrayString[1]]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toCardInfo"){
            //User info
            (segue.destination as! SignUp5).firstName = self.firstName
            (segue.destination as! SignUp5).lastName = self.lastName
            (segue.destination as! SignUp5).sexe = self.sexe
            (segue.destination as! SignUp5).birthdate = self.birthdate
            (segue.destination as! SignUp5).phone = self.phone
            (segue.destination as! SignUp5).email = self.email
            (segue.destination as! SignUp5).password = self.password
        }
    }
}
