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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        setUPTopCard()
        setFakeNavBar()
        setUpMidPart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setFakeNavBar(){
    
        let fakeBar = UIView()
        fakeBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        fakeBar.backgroundColor = UIColor.white
        self.containerView.addSubview(fakeBar)
        
        Utility().createHR(x: 0, y: fakeBar.frame.height - 1, width: view.frame.width, view: fakeBar, color: Utility().hexStringToUIColor(hex: "#DCDCDC"))
        
        let geekIcon = UIButton(type: .system)
        geekIcon.tintColor = Utility().hexStringToUIColor(hex: "#6CA743")
        geekIcon.setImage(#imageLiteral(resourceName: "menuLeftImage"),for:.normal)
        geekIcon.frame = CGRect(x: 18, y: fakeBar.frame.height/1.5 - 16, width: 22, height: 28)
        fakeBar.addSubview(geekIcon)
        
        
        let menuButton = UIButton(type: .system)
        menuButton.frame = CGRect(x: view.frame.width - 40, y: fakeBar.frame.height/1.5 - 17, width: 34, height: 34)
        menuButton.addTarget(self, action: #selector(triggerMenu), for: .touchUpInside)
        menuButton.tintColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        menuButton.setImage(#imageLiteral(resourceName: "open_menu"),for:.normal)
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        fakeBar.addSubview(menuButton)
        
        let title = UILabel()
        title.frame = CGRect(x: (view.frame.width/2 - rw(100)), y: (menuButton.frame.midY) - rh(10), width: rw(200), height: rh(20))
        title.text = "Accueil"
        title.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        title.textAlignment = .center
        title.font = UIFont(name: "Lato-Bold", size: rw(17))
        fakeBar.addSubview(title)
        
    }
    
    func setUPTopCard(){
        
        cardView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: rh(191))
        cardView.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        cardView.makeShadow(x: 9, y: -10, blur: 38, cornerRadius: 0, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.5, spread: 0)
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
        
        let greenCard = UIImageView()
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
    
    func triggerMenu(){
        menu.triggerMenu(view: containerView)
    }
    
    func commanderPressed(sender:UIButton){
        print("Commande")
    }
    
    func abonnementPressed(sender:UIButton){
        print("Abonnement")
    }
    
    func promotionPressed(sender:UIButton){
        print("Promotion")
    }
}






