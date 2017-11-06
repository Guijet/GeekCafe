//
//  Dashboard.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-13.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class Dashboard:UIViewController{
    
    let cardView = UIView()
    let labelNbPoints = UILabel()
    let menu = MenuClass()
    let containerView = UIView()
    let greenCard = UIImageView()
    let whiteButton = UIButton()
    let tapOnCard = UITapGestureRecognizer()
    let tapOnCardClose = UITapGestureRecognizer()
    let load = loadingIndicator()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        load.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.main.async {
            self.menu.setUpMenu(view: self.view)
            self.setUpContainerView()
            self.setUPTopCard()
            self.menu.setUpFakeNavBar(view:self.containerView,titleTop:"Accueil")
            self.setUpMidPart()
            self.load.stopAnimatingAndRemove(view: self.view)
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
    
    func setUPTopCard(){
        
        cardView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: rh(191))
        cardView.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        cardView.makeShadow(x: 9, y: -10, blur: 21, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.5, spread: 0)
        containerView.addSubview(cardView)
        
        let geekImg = UIImageView()
        geekImg.frame = CGRect(x: rw(264), y: rh(98), width: rw(111), height: rh(157))
        geekImg.image = UIImage(named: "geek_dash")
        containerView.addSubview(geekImg)
        
        let bienVenueLabel = UILabel()
        bienVenueLabel.frame = CGRect(x: rw(28), y: rh(137), width: rw(184), height: rh(21))
        bienVenueLabel.text = "Bienvenue au"
        bienVenueLabel.textColor = Utility().hexStringToUIColor(hex: "#CCCCCC")
        bienVenueLabel.font = UIFont(name: "Lato-Regular", size: rw(17))
        bienVenueLabel.textAlignment = .left
        containerView.addSubview(bienVenueLabel)
        
        let geekTitle = UIImageView()
        geekTitle.frame = CGRect(x: rw(29), y: rh(157), width: rw(184), height: rh(31))
        geekTitle.image = UIImage(named: "geektext_dash")
        containerView.addSubview(geekTitle)
    }
    
    func setUpMidPart(){
        let midLabel = UILabel()
        midLabel.frame = CGRect(x: rw(22), y: cardView.frame.maxY + rh(14), width: rw(317.7), height: rh(26))
        midLabel.text = "Que voulez-vous?"
        midLabel.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        midLabel.font = UIFont(name: "Lato-Regular", size: rw(18))
        midLabel.textAlignment = .left
        containerView.addSubview(midLabel)
        
        //BOUTON 1
        let firstButton = UIButton()
        firstButton.frame = CGRect(x: rw(8), y: midLabel.frame.maxY + rh(16), width: rw(360), height: rh(61))
        firstButton.backgroundColor = UIColor.white
        firstButton.makeShadow(x: 2, y: 2, blur: 4, cornerRadius: 10, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.09, spread: 1)
        firstButton.addTarget(self, action: #selector(commanderPressed(sender:)), for: .touchUpInside)
        containerView.addSubview(firstButton)
        
        let firstButtonText = UILabel()
        firstButtonText.frame = CGRect(x: rw(29), y: (firstButton.frame.height/2) - rh(13), width: rw(281), height: rh(26))
        firstButtonText.text = "Commander"
        firstButtonText.textAlignment = .left
        firstButtonText.font = UIFont(name: "Lato-Light", size: rw(25))
        firstButtonText.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        firstButton.addSubview(firstButtonText)
        
        let arrowImage = UIImageView()
        arrowImage.frame = CGRect(x: rw(327), y: firstButton.frame.height/2 - rw(13), width: rw(26), height: rw(26))
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.image = #imageLiteral(resourceName: "right_arrow")
        firstButton.addSubview(arrowImage)
        
        //BOUTON 2
        let secondButton = UIButton()
        secondButton.frame = CGRect(x: rw(8), y: firstButton.frame.maxY + rh(16), width: rw(360), height: rh(61))
        secondButton.backgroundColor = UIColor.white
        secondButton.makeShadow(x: 2, y: 2, blur: 4, cornerRadius: 10, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.09, spread: 1)
        secondButton.addTarget(self, action: #selector(abonnementPressed(sender:)), for: .touchUpInside)
        containerView.addSubview(secondButton)
        
        let secondButtonText = UILabel()
        secondButtonText.frame = CGRect(x: rw(29), y: (secondButton.frame.height/2) - rh(13), width: rw(281), height: rh(26))
        secondButtonText.text = "Abonnement"
        secondButtonText.textAlignment = .left
        secondButtonText.font = UIFont(name: "Lato-Light", size: rw(25))
        secondButtonText.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        secondButton.addSubview(secondButtonText)
        
        let arrowImage2 = UIImageView()
        arrowImage2.frame = CGRect(x: rw(327), y: secondButton.frame.height/2 - rw(13), width: rw(26), height: rw(26))
        arrowImage2.contentMode = .scaleAspectFit
        arrowImage2.image = #imageLiteral(resourceName: "right_arrow")
        secondButton.addSubview(arrowImage2)
        
        //BOUTON 3
        let thirdButton = UIButton()
        thirdButton.frame = CGRect(x: rw(8), y: secondButton.frame.maxY + rh(16), width: rw(360), height: rh(61))
        thirdButton.backgroundColor = UIColor.white
        thirdButton.makeShadow(x: 2, y: 2, blur: 4, cornerRadius: 10, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.09, spread: 1)
        thirdButton.addTarget(self, action: #selector(promotionPressed(sender:)), for: .touchUpInside)
        containerView.addSubview(thirdButton)
        
        let thirdButtonText = UILabel()
        thirdButtonText.frame = CGRect(x: rw(29), y: (thirdButton.frame.height/2) - rh(13), width: rw(281), height: rh(26))
        thirdButtonText.text = "Promotions"
        thirdButtonText.textAlignment = .left
        thirdButtonText.font = UIFont(name: "Lato-Light", size: rw(25))
        thirdButtonText.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        thirdButton.addSubview(thirdButtonText)
        
        let arrowImage3 = UIImageView()
        arrowImage3.frame = CGRect(x: rw(327), y: thirdButton.frame.height/2 - rw(13), width: rw(26), height: rw(26))
        arrowImage3.contentMode = .scaleAspectFit
        arrowImage3.image = #imageLiteral(resourceName: "right_arrow")
        thirdButton.addSubview(arrowImage3)
        
        tapOnCard.addTarget(self, action: #selector(animateForPoints(sender:)))
        tapOnCardClose.addTarget(self, action: #selector(animateCloseCard(sender:)))
        
        greenCard.isUserInteractionEnabled = true
        greenCard.addGestureRecognizer(tapOnCard)
        greenCard.frame = CGRect(x: rw(3), y: rh(586), width: rw(370), height: rh(70))
        greenCard.image = UIImage(named: "greenCard_dash")
        containerView.addSubview(greenCard)
        
        let labelAccumuler = UILabel()
        labelAccumuler.frame = CGRect(x: rw(24), y: (greenCard.frame.height/2) - rh(12), width: rw(178), height: rh(24))
        labelAccumuler.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        labelAccumuler.text = "Vous avez accumulé"
        labelAccumuler.textAlignment = .left
        labelAccumuler.font = UIFont(name: "Lato-Regular", size: rw(20))
        greenCard.addSubview(labelAccumuler)
        
        labelNbPoints.frame = CGRect(x: rw(223), y: rh(3), width: rw(70), height: greenCard.frame.height - rh(6))
        labelNbPoints.text = "106"
        labelNbPoints.textAlignment = .left
        labelNbPoints.textColor = .white
        labelNbPoints.font = UIFont(name: "Lato-Regular", size: rw(40))
        greenCard.addSubview(labelNbPoints)
        
        let labelPoint = UILabel()
        labelPoint.frame = CGRect(x: rw(298), y:labelNbPoints.frame.height/2 - rh(5), width: rw(50), height: rh(22))
        labelPoint.text = "points"
        labelPoint.textAlignment = .left
        labelPoint.textColor = .white
        labelPoint.font = UIFont(name: "Lato-Regular", size: rw(18))
        greenCard.addSubview(labelPoint)
        
    }
    
    func buildCardWhite(){
        
        whiteButton.frame = CGRect(x: rw(7.5), y: rh(586), width: rw(360.5), height: rh(60))
        whiteButton.backgroundColor = UIColor.white
        whiteButton.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        whiteButton.addTarget(self, action: #selector(convertPointsToMone), for: .touchUpInside)
        
        let attrs1 = [NSFontAttributeName : UIFont(name:"Lato-Light",size:rw(16))!, NSForegroundColorAttributeName : Utility().hexStringToUIColor(hex: "#AFAFAF")]
        let attrs2 = [NSFontAttributeName : UIFont(name:"Lato-Light",size:rw(22))!, NSForegroundColorAttributeName : Utility().hexStringToUIColor(hex: "#AFAFAF")]
        let attributedString1 = NSMutableAttributedString(string:"Convertir en crédit ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"$3.54", attributes:attrs2)
        attributedString1.append(attributedString2)
        
        let LBL_Button = UILabel()
        LBL_Button.frame = CGRect(x: 0, y: rh(28), width: whiteButton.frame.width, height: rh(25))
        LBL_Button.textAlignment = .center
        LBL_Button.attributedText = attributedString1
        whiteButton.addSubview(LBL_Button)
        
        containerView.addSubview(whiteButton)
    }
    
    func animateForPoints(sender:UITapGestureRecognizer){
        self.view.isUserInteractionEnabled = false
        self.buildCardWhite()
        self.whiteButton.layer.zPosition = -1
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.greenCard.center.y -= self.rh(41)
            self.whiteButton.center.y += self.rh(4)
            self.whiteButton.frame.size.height += self.rh(7)
            
        }, completion: { _ in
            self.greenCard.removeGestureRecognizer(self.tapOnCard)
            self.greenCard.addGestureRecognizer(self.tapOnCardClose)
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func animateCloseCard(sender:UITapGestureRecognizer){
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.greenCard.center.y += self.rh(41)
            self.whiteButton.center.y -= self.rh(4)
            self.whiteButton.frame.size.height -= self.rh(7)
        }, completion: { _ in
            self.whiteButton.removeFromSuperview()
            self.greenCard.removeGestureRecognizer(self.tapOnCardClose)
            self.greenCard.addGestureRecognizer(self.tapOnCard)
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func convertPointsToMone(){
        print("Convert")
    }
    
    func commanderPressed(sender:UIButton){
        let storyboard = UIStoryboard(name: "Commande", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "CommmandeMainPage")
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.keyWindow?.rootViewController = main
        }, completion: nil)
    }
    
    func abonnementPressed(sender:UIButton){
        let storyboard = UIStoryboard(name: "Abonnement", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "AbonnementMain")
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.keyWindow?.rootViewController = main
        }, completion: nil)
    }
    
    func promotionPressed(sender:UIButton){
        let storyboard = UIStoryboard(name: "Promotions", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "PromotionMainPage")
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.keyWindow?.rootViewController = main
        }, completion: nil)
    }
}






