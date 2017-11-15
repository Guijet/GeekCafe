//
//  MainPageCredit.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import Stripe
import AFNetworking
import AVFoundation

class MainPageCredit: UIViewController,UITextFieldDelegate,CardIOViewDelegate{

    let menu = MenuClass()
    var arrayCards = [userCard]()
    let scrollView = UIScrollView()
    let containerView = UIView()
    let buttonAddCard = UIButton()
    
    //
    //PAYMENTS
    let TB_CardNumber = UITextField()
    let TB_Expiration = UITextField()
    let TB_CardHolderName = UITextField()
    let TB_CVC = UITextField()
    
    //CARD IO
    let containerViewCard = UIView()
    let contentViewIO = UIView()
    let cardIOView = CardIOView()
    
    //Loading VIew
    let load = loadingIndicator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos: .background).async {
            self.arrayCards = Global.global.userInfo.cards
            DispatchQueue.main.async {
                self.menu.setUpMenu(view: self.view)
                self.setUpContainerView()
                self.menu.setUpFakeNavBar(view: self.containerView, titleTop: "Paiements")
                self.setUpScrollView()
                self.setUpBottomButton()
                self.fillScrollView()
                self.load.stopAnimatingAndRemove(view: self.view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setUpBottomButton(){
        
        buttonAddCard.frame = CGRect(x: 0, y: rh(601), width: view.frame.width, height: rh(66))
        buttonAddCard.backgroundColor = UIColor.white
        buttonAddCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        buttonAddCard.setTitle("Change payment method", for: .normal)
        if(Global.global.userInfo.cards.count <= 0){
            buttonAddCard.setTitle("Add payment method", for: .normal)
        }
        buttonAddCard.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonAddCard.addTarget(self, action: #selector(addCardPressed), for: .touchUpInside)
        containerView.addSubview(buttonAddCard)
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - (64 + rh(66)))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var newY:CGFloat = rh(22)
        if(arrayCards.count > 0){
            for x in arrayCards{
                
                let container = UIView()
                container.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(89))
                container.backgroundColor = UIColor.clear
                scrollView.addSubview(container)
                
                let button = UIButton()
                button.frame = CGRect(x: 0, y: 0, width: rw(360), height: rh(89))
                button.addTarget(self, action: #selector(deleteCardAnimation(sender:)), for: .touchUpInside)
                button.accessibilityIdentifier = x.id_card
                button.backgroundColor = UIColor.white
                button.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
                container.addSubview(button)
                
                let providerImage = UIImageView()
                providerImage.frame = CGRect(x: rw(16), y: rh(31), width: rw(68), height: rh(24))
                providerImage.image = UIImage(named:"visaList")
                providerImage.contentMode = .scaleAspectFit
                button.addSubview(providerImage)
                
                let labelCardNumber = UILabel()
                labelCardNumber.frame = CGRect(x: rw(93), y: rh(27), width: rw(267), height: rh(30))
                labelCardNumber.text = "****    ****    ****    \(x.last4)"
                labelCardNumber.font = UIFont(name: "Lato-Light", size: rw(22))
                labelCardNumber.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                labelCardNumber.textAlignment = .center
                button.addSubview(labelCardNumber)
                
                
                newY += rh(108)
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
        else{
            let labelNoCard = UILabel()
            labelNoCard.numberOfLines = 2
            labelNoCard.createLabel(frame: CGRect(x:0,y:rh(225),width:view.frame.width,height:50), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(16), textAignment: .center, text: "Vous n'avez présentement aucune \nméthode de paiement enregistrée")
            scrollView.addSubview(labelNoCard)
        }
    }
    
    func isOpen(view:UIView)->Bool{
        return view.frame.height > rh(89)
    }
    
    func getAllViewDown(yAt:CGFloat)->[UIView]{
        var arrayViews = [UIView]()
        for x in scrollView.subviews{
            if(x.frame.minY > yAt){
                arrayViews.append(x)
            }
        }
        return arrayViews
    }
    
    func moveAllDown(yAt:CGFloat){
        let arrayViews = getAllViewDown(yAt: yAt)
        for x in arrayViews{
            x.frame.origin.y += rh(50)
        }
        scrollView.contentSize.height += rh(50)
    }
    
    func moveAllViewUp(yAt:CGFloat){
        let arrayViews = getAllViewDown(yAt: yAt)
        for x in arrayViews{
            x.frame.origin.y -= rh(50)
        }
        scrollView.contentSize.height -= rh(50)
    }
    
    func removeDeleteButton(container:UIView){
        var deleteView = UIView()
        for x in container.subviews{
            if(x.accessibilityIdentifier == "DeleteButton"){
                deleteView = x
                break
            }
        }
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            deleteView.center.y -= self.rh(55)
            
        },completion: { _ in
            deleteView.removeFromSuperview()
            container.frame.size.height -= self.rh(55)
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func openButtonDelete(superView:UIView, sender:UIButton){
        superView.frame.size.height += rh(55)
        
        let redButton = UIButton()
        redButton.accessibilityIdentifier = "DeleteButton"
        redButton.layer.zPosition = -1
        redButton.frame = CGRect(x: 0, y: sender.frame.maxY - rh(65), width: sender.frame.width, height: rh(65))
        redButton.backgroundColor = Utility().hexStringToUIColor(hex: "#FF7272")
        redButton.addTarget(self, action: #selector(deleteCard(sender:)), for: .touchUpInside)
        redButton.setTitle("Supprimer cette carte", for: .normal)
        redButton.setTitleColor(UIColor.white, for: .normal)
        redButton.titleLabel?.font = UIFont(name: "Lato-Light", size: rw(22))
        redButton.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        superView.addSubview(redButton)
        
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            redButton.center.y += self.rh(55)
        },completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    @objc func deleteCardAnimation(sender:UIButton){
        if(!isOpen(view: sender.superview!)){
            openButtonDelete(superView: sender.superview!,sender: sender)
        }
        else{
            
            removeDeleteButton(container: sender.superview!)
        }
    }
    
    @objc func deleteCard(sender:UIButton){
        load.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos:.background).async {
            if(APIRequestPaiement().deleteCard(card_token: Global.global.userInfo.cards[0].id_card)){
                DispatchQueue.main.async {
                    Utility().alert(message: "Votre carte a été supprimer.", title: "Message", control: self, f: self.refreshScrollView)
                    self.load.stopAnimatingAndRemove(view: self.view)
                }
            }
            else{
                DispatchQueue.main.async {
                    Utility().alert(message: "Erreur lors de la suppression de votre carte.", title: "Erreur", control: self)
                    self.load.stopAnimatingAndRemove(view: self.view)
                }
            }
        }
        
    }
    
    func buildAddCardView(){
        
        containerViewCard.makeShadow(x: 0, y: 8, blur: 17, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 3)
        
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(50))
        header.backgroundColor = Utility().hexStringToUIColor(hex: "#F7F7F7")
        containerViewCard.addSubview(header)
        
        let tapAddCard = UITapGestureRecognizer()
        tapAddCard.addTarget(self, action: #selector(addCard))
        

        let addButton = UIButton()
        addButton.frame = CGRect(x: rw(280), y: rh(7.5), width: rw(75), height: rh(35))
        addButton.setTitle("Add Card", for: .normal)
        addButton.setTitleColor(Utility().hexStringToUIColor(hex: "#16E9A6"), for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(15))
        addButton.addTarget(self, action: #selector(addOrChangeCard), for: .touchUpInside)
        header.addSubview(addButton)
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: rw(20), y: rh(10), width: rw(60), height: rh(30))
        closeButton.setTitle("Fermer", for: .normal)
        closeButton.setTitleColor(Utility().hexStringToUIColor(hex: "#000000"), for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(13))
        closeButton.addTarget(self, action: #selector(animateBottomClose), for: .touchUpInside)
        header.addSubview(closeButton)
        
        
        containerViewCard.frame = CGRect(x: 0, y: view.frame.maxY, width: view.frame.width, height: rh(370))
        containerViewCard.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        containerView.addSubview(containerViewCard)
        
        let topCard = UIView()
        topCard.frame = CGRect(x: rw(28), y: rh(75), width: rw(319), height: rh(172))
        topCard.backgroundColor = UIColor.white
        topCard.makeShadow(x: 0, y: 2, blur: 7, cornerRadius: 5, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        containerViewCard.addSubview(topCard)
        
        let labelCardNumber = UILabel()
        labelCardNumber.frame = CGRect(x: rw(14), y: rh(36), width: rw(84), height: rh(11))
        labelCardNumber.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        labelCardNumber.font = UIFont(name: "Lato-Bold", size: rw(9))
        labelCardNumber.textAlignment = .left
        labelCardNumber.text = "CARD NUMBER".uppercased()
        topCard.addSubview(labelCardNumber)
        
        let cameraButton = UIButton()
        cameraButton.frame = CGRect(x: rw(130), y: rh(105), width: rw(25), height: rw(25))
        cameraButton.setImage(UIImage(named:"CameraButton"), for: .normal)
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 4, right: 3)
        cameraButton.addTarget(self, action: #selector(showCardIOView(sender:)), for: .touchUpInside)
        //view.addSubview(cameraButton)
        
        TB_CardNumber.delegate = self
        TB_CardNumber.autocorrectionType = .no
        TB_CardNumber.keyboardType = .numberPad
        TB_CardNumber.frame = CGRect(x: rw(137), y: rh(32), width: rh(168), height: rh(17))
        TB_CardNumber.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_CardNumber.placeholder = "Numéro de carte"
        TB_CardNumber.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(14))
        TB_CardNumber.font = UIFont(name: "Lato-Regular", size: rw(15))
        TB_CardNumber.textAlignment = .right
        topCard.addSubview(TB_CardNumber)
        
        Utility().createHR(x: rw(14), y: rh(56), width: rw(291), view: topCard, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        
        let expirationDate = UILabel()
        expirationDate.frame = CGRect(x: rw(14), y: rh(86), width: rw(87), height: rh(11))
        expirationDate.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        expirationDate.font = UIFont(name: "Lato-Bold", size: rw(9))
        expirationDate.textAlignment = .left
        expirationDate.text = "EXPIRATION DATE".uppercased()
        topCard.addSubview(expirationDate)
        
        TB_Expiration.delegate = self
        TB_Expiration.autocorrectionType = .no
        TB_Expiration.keyboardType = .numberPad
        TB_Expiration.frame = CGRect(x: rw(124), y: rh(81), width: rh(70), height: rh(17))
        TB_Expiration.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_Expiration.font = UIFont(name: "Lato-Regular", size: rw(14))
        TB_Expiration.placeholder = "Expiration"
        TB_Expiration.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(14))
        TB_Expiration.textAlignment = .right
        topCard.addSubview(TB_Expiration)
        
        let labelCVC = UILabel()
        labelCVC.frame = CGRect(x: rw(217), y: rh(86), width: rw(23), height: rh(17))
        labelCVC.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        labelCVC.font = UIFont(name: "Lato-Bold", size: rw(9))
        labelCVC.textAlignment = .left
        labelCVC.text = "CVC".uppercased()
        topCard.addSubview(labelCVC)
        
        TB_CVC.delegate = self
        TB_CVC.autocorrectionType = .no
        TB_CVC.keyboardType = .numberPad
        TB_CVC.frame = CGRect(x: rw(267), y: rh(81), width: rh(36), height: rh(17))
        TB_CVC.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_CVC.placeholder = "CVC"
        TB_CVC.font = UIFont(name: "Lato-Regular", size: rw(14))
        TB_CVC.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(12))
        TB_CVC.textAlignment = .right
        topCard.addSubview(TB_CVC)
        
        Utility().createHR(x: rw(14), y: rh(103), width: rw(180), view: topCard, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        Utility().createHR(x: rw(217), y: rh(102), width: rw(88), view: topCard, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        
        
        let labelCardHolder = UILabel()
        labelCardHolder.frame = CGRect(x: rw(14), y: rh(132), width: rw(100), height: rh(11))
        labelCardHolder.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        labelCardHolder.font = UIFont(name: "Lato-Bold", size: rw(9))
        labelCardHolder.textAlignment = .left
        labelCardHolder.text = "CARDHOLDER NAME".uppercased()
        topCard.addSubview(labelCardHolder)
        
        TB_CardHolderName.delegate = self
        TB_CardHolderName.autocorrectionType = .no
        TB_CardHolderName.frame = CGRect(x: rw(120), y: rh(129), width: rh(180), height: rh(17))
        TB_CardHolderName.textColor = Utility().hexStringToUIColor(hex: "#171616")
        TB_CardHolderName.placeholder = "Card Holder Name"
        TB_CardHolderName.font = UIFont(name: "Lato-Regular", size: rw(14))
        TB_CardHolderName.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(12))
        TB_CardHolderName.textAlignment = .right
        topCard.addSubview(TB_CardHolderName)
        
        Utility().createHR(x: rw(14), y: rh(149), width: rw(291), view: topCard, color: Utility().hexStringToUIColor(hex: "#EEEEEE"))
        
        let ouLBL = UILabel()
        ouLBL.frame = CGRect(x: 0, y:rh(272), width: view.frame.width, height: containerView.rh(19))
        ouLBL.text = "- OU -"
        ouLBL.textAlignment = .center
        ouLBL.font = UIFont(name: "Lato-Bold", size:rw(16))
        ouLBL.textColor = Utility().hexStringToUIColor(hex: "#505050")
        containerViewCard.addSubview(ouLBL)
        
        let BTN_CardIO = UIButton()
        BTN_CardIO.createCreateButton(title: "Scanner votre carte", frame: CGRect(x:rw(38),y:rh(300),width:rw(300),height:rh(48)), fontSize: rw(13), containerView: containerViewCard)
        BTN_CardIO.addTarget(self, action: #selector(showCardIOView), for: .touchUpInside)
        
        
    }
    
    func animateBottomOpen(){
        //BuildView
        buildAddCardView()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.containerViewCard.center.y -= self.rh(370)
        },completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    @objc func animateBottomClose(){
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.containerViewCard.center.y += self.rh(370)
        },completion: { _ in
            self.view.isUserInteractionEnabled = true
            self.containerViewCard.removeFromSuperview()
        })
    }
    
    @objc func addCardPressed(){
        animateBottomOpen()
    }
    
    @objc func addCard(){
        print("perform selector for add card")
    }
    
    func emptyScrollView(){
        if(scrollView.subviews.count > 0){
            for x in scrollView.subviews{
                x.removeFromSuperview()
            }
        }
    }
    
    func refreshScrollView(){
        load.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos:.background).async {
            Global.global.userInfo.cards = APIRequestLogin().indexPaymentsMethod(cardHolderName: "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)")
            self.arrayCards = Global.global.userInfo.cards
            DispatchQueue.main.async {
                self.emptyScrollView()
                self.fillScrollView()
                self.load.stopAnimatingAndRemove(view: self.view)
            }
        }
    }
    
    
    //
    //
    //
    //TEXTFIELDS DELEGATE METHODS
    //AND ENTRY ENDPOINTS
    //
    //
    //
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if(textField == TB_Expiration){
            let lenght = textField.text?.count
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
            let lenght = textField.text?.count
            if(lenght! > 2){
                if (isBackSpace != -92) {
                    return false
                }
            }
        }
        
        if(textField == TB_CardNumber){
            let lenght = textField.text?.count
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
        for x in number{
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
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    
    @objc func addOrChangeCard(){
        if(TB_CVC.text != "" && TB_CardNumber.text != "" && TB_Expiration.text != "" && TB_CardHolderName.text != ""){
            load.buildViewAndStartAnimate(view: self.view)
            let cardNumber:String = self.TB_CardNumber.text!.components(separatedBy: .whitespaces).joined()
            let cvv:String = self.TB_CVC.text!
            let expMounth:String = self.splitExpiration(expiration: self.TB_Expiration.text!)[0]
            let expYear:String = self.splitExpiration(expiration: self.TB_Expiration.text!)[1]
            DispatchQueue.global(qos:.background).async {
                self.getCardToken(cardNumber: cardNumber, cvv: cvv, expiryMonth: expMounth, expiryYear: expYear)
                
            }
        }
        else{
            Utility().alert(message: "You need to fill all fields", title: "Message", control: self)
        }
        
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
                DispatchQueue.main.async {
                    self.load.stopAnimatingAndRemove(view: self.view)
                }
                if error == nil {
                    if(APIRequestLogin().addPaymentMethod(card_token:token!.tokenId)){
                        DispatchQueue.main.async {
                            self.resetWhenCardAdded()
                        }
                    }
                    else{
                        Utility().alert(message: "Erreur avec la carte entrer", title: "Erreur", control: self)
                    }
                }
                else{
                    Utility().alert(message: "Erreur lors de la création de compte.", title: "Erreur", control: self)
                }
            })
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    func resetWhenCardAdded(){
        animateBottomClose()
        TB_CardHolderName.text = ""
        TB_Expiration.text = ""
        TB_CardNumber.text = ""
        TB_CVC.text = ""
        refreshScrollView()
    }
    
    func splitExpiration(expiration:String)->[String]{
        let arrayString = expiration.components(separatedBy: "/")
        return [arrayString[0],arrayString[1]]
    }
    //
    //
    //CARD IO
    //
    //
    @objc func showCardIOView(sender:UIButton){
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
    
    @objc func removeViewIO(){
        TB_CardNumber.becomeFirstResponder()
        self.navigationController?.navigationBar.isHidden = false
        contentViewIO.removeFromSuperview()
    }

    
    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        TB_CardNumber.text = splitCardNumberWithSpace(number:cardInfo.cardNumber)
        TB_Expiration.text = "\(cardInfo.expiryMonth) / \(cardInfo.expiryYear)"
        TB_CardHolderName.text = cardInfo.cardholderName
        removeViewIO()
    }
    
}
