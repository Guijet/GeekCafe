//
//  SignUp5.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class SignUp5: UIViewController {

    //Button and background
    let backgroundImage = UIImageView()
    let nextButton = UIButton()
    
    //Card Image components
    let cardImage = UIImageView()
    let pinImage = UIImageView()
    let cardProviderImage = UIImageView()
    let cardNumber = UILabel()
    let validFrom = UILabel()
    let untilEnd = UILabel()
    let fromDate = UILabel()
    let endDate = UILabel()
    let name = UILabel()
    
    //Textview information
    let textView = UITextView()
    
    
    var user:User!
    //user information
    var firstName:String!
    var lastName:String!
    var sexe:String!
    var birthdate:String!
    var phone:String!
    var email:String!
    var password:String!
    
    //Carte information
    var last4:String!
    var expYear:String!
    var expMonth: String!
    var brand: String!
    var cardName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setUpCardImage()
        setUptext()
        setUpButton()
        loadUserInformation()
    }
    
    
    //Set up image of green card
    func setUpCardImage(){
        cardImage.frame = CGRect(x: rw(25), y: rh(183), width: view.frame.width - rw(50), height: rh(193))
        cardImage.image = UIImage(named: "CardInfoIMG")
        view.addSubview(cardImage)
        
        pinImage.frame = CGRect(x: rw(46), y: rh(240), width: rw(45), height: rw(41))
        pinImage.image = UIImage(named: "CardPin")
        view.addSubview(pinImage)
        
        cardNumber.frame = CGRect(x: rw(47), y: rh(290), width: rw(266), height: rh(22))
        cardNumber.text = "4363  1234  5678  9101"
        cardNumber.font = UIFont(name: "Lato-Light", size: rw(22))
        cardNumber.textAlignment = .left
        cardNumber.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        cardNumber.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#2D2D2D"), shadowOpacity: 1, spread: 0)
        view.addSubview(cardNumber)
        
        validFrom.frame = CGRect(x: rw(53), y: rh(327.5), width: rw(17), height: rh(15))
        validFrom.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        validFrom.font = UIFont(name: "Lato-Light", size: rw(5))
        validFrom.textAlignment = .left
        validFrom.numberOfLines = 2
        validFrom.lineBreakMode = .byTruncatingHead
        validFrom.text = "VALID\nFROM".uppercased()
        validFrom.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#2D2D2D"), shadowOpacity: 1, spread: 0)
        view.addSubview(validFrom)
        
        fromDate.frame = CGRect(x: rw(73), y: rh(330), width: rw(40), height: rh(10))
        fromDate.text = "01/17"
        fromDate.font = UIFont(name: "Lato-Light", size: rw(10))
        fromDate.textAlignment = .left
        fromDate.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        fromDate.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#2D2D2D"), shadowOpacity: 1, spread: 0)
        view.addSubview(fromDate)
        
        untilEnd.frame = CGRect(x: rw(140), y: rh(327.5), width: rw(17), height: rh(15))
        untilEnd.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        untilEnd.font = UIFont(name: "Lato-Light", size: rw(5))
        untilEnd.textAlignment = .left
        untilEnd.numberOfLines = 2
        untilEnd.lineBreakMode = .byTruncatingHead
        untilEnd.text = "UNTIL\nEND".uppercased()
        untilEnd.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#2D2D2D"), shadowOpacity: 1, spread: 0)
        view.addSubview(untilEnd)
        
        endDate.frame = CGRect(x: rw(160), y: rh(330), width: rw(40), height: rh(10))
        endDate.text = "01/21"
        endDate.font = UIFont(name: "Lato-Light", size: rw(10))
        endDate.textAlignment = .left
        endDate.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        endDate.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#2D2D2D"), shadowOpacity: 1, spread: 0)
        view.addSubview(endDate)
        
        name.frame = CGRect(x: rw(51), y: rh(348.86), width: rw(180), height: rh(13))
        name.text = "Guillaume Jetté-Tremblay"
        name.font = UIFont(name: "Lato-Light", size: rw(13))
        name.textAlignment = .left
        name.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        name.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#2D2D2D"), shadowOpacity: 1, spread: 0)
        name.sizeToFit()
        view.addSubview(name)
        
        
        cardProviderImage.frame = CGRect(x: rw(262.69), y: rh(334.86), width: rw(71.68), height: rh(23.58))
        cardProviderImage.image = UIImage(named: "Visa")
        view.addSubview(cardProviderImage)
        
        
    }
    
    //Text in gray
    func setUptext(){
        textView.frame = CGRect(x: rw(29), y: rh(420), width: view.frame.width - rw(58), height: rh(51))
        textView.textAlignment = .center
        textView.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        textView.font = UIFont(name: "Lato-Regular", size: rw(14))
        textView.backgroundColor = UIColor.clear
        textView.text = "By clicking I agree, you agree that you have had an opportunity to review and are consenting without reservation to the following terms and conditions"
        textView.sizeToFit()
        view.addSubview(textView)
    }
    
    //Bottom Button
    func setUpButton(){
        nextButton.createCreateButton(title: "Terminé", frame: CGRect(x: rw(88), y: rh(553), width: rw(200), height: rh(50)),fontSize:rw(20),containerView:self.view)
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
    }
    
    func loadUserInformation(){
        //Faire le loading des information de la carte
    }
    
    func nextPressed(sender:UIButton){
        //Create Account and add Global Card and UserInfo
        if(APIRequestLogin().createAcount(first_name: firstName, last_name: lastName, gender: sexe, birth_date: birthdate, phone: phone, email: email, password: password)){
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let main = storyboard.instantiateViewController(withIdentifier: "MainPage")
            UIApplication.shared.keyWindow?.rootViewController = main
        }
        else{
            Utility().alert(message: "Impossible de créer le compte réessayer plus tard", title: "Erreur", control: self)
        }
        
    }
}
