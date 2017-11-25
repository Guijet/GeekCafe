//
//  AbonnementMainPage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class AbonnementMainPage: UIViewController {

    let menu = MenuClass()
    let containerView = UIView()
    let backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MENU SET UP
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Abonnements")
        
        //Page Set UP UI
        backgroundImage.setUpBackgroundImage(containerView: containerView)
        setUpBottomView()
        setUpTopCard()
        setUpBottomButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setUpTopCard(){
        let greenCard = UIView()
        greenCard.frame = CGRect(x: rw(8), y: rh(92), width: rw(360), height: rh(179))
        //greenCard.backgroundColor = UIColor(red: 22.0 / 255.0, green: 233.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
        greenCard.layer.cornerRadius = rw(8)
        containerView.addSubview(greenCard)
        
        let gradient = CAGradientLayer()
        gradient.frame = greenCard.bounds
        gradient.cornerRadius = 8
        gradient.colors = [Utility().hexStringToUIColor(hex: "15EA6D").cgColor, Utility().hexStringToUIColor(hex: "#16E9A6").cgColor]
        greenCard.layer.insertSublayer(gradient, at: 0)
        
        let logoBackGroundCard = UIImageView()
        logoBackGroundCard.frame = CGRect(x: rw(257), y: rh(107), width: rw(111), height: rh(163))
        logoBackGroundCard.image = UIImage(named: "geekAboonmentCard")
        containerView.addSubview(logoBackGroundCard)
        
        let titleMember = UILabel()
        titleMember.frame = CGRect(x: rw(28), y: rh(162), width: rw(184), height: rh(22))
        titleMember.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        titleMember.font = UIFont(name: "Lato-Regular", size: rw(18))
        titleMember.textAlignment = .left
        titleMember.text = "Membre premium"
        containerView.addSubview(titleMember)
        
        let imageBrandText = UIImageView()
        imageBrandText.frame = CGRect(x: rw(28.5), y: rh(183), width: rw(184), height: rh(33))
        imageBrandText.image = UIImage(named: "titleAbonnementCard")
        containerView.addSubview(imageBrandText)
    }
    
    func setUpBottomView(){
        let viewBot = UIView()
        viewBot.frame = CGRect(x: rw(8), y: rh(225), width: rw(360), height: rh(219))
        viewBot.backgroundColor = UIColor.white
        viewBot.makeShadow(x: 2, y: 2, blur: 4, cornerRadius: 10, shadowColor: UIColor.black, shadowOpacity: 0.09, spread: 1)
        containerView.addSubview(viewBot)
        
        
        let textView = UILabel()
        textView.frame = CGRect(x: rw(24), y: rh(280), width: view.frame.width - rw(48), height: rh(70))
        textView.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        textView.font = UIFont(name: "Lato-Light", size: rw(16))
        textView.textAlignment = .left
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
        textView.numberOfLines = 3
        textView.lineBreakMode = .byTruncatingHead
        textView.addCharactersSpacing(spacing: -0.85, text: textView.text!)
        containerView.addSubview(textView)
        
        let imageleft = UIImageView()
        imageleft.frame = CGRect(x: rw(56), y: textView.frame.maxY + rh(20), width: rw(35), height: rw(35))
        imageleft.image = UIImage(named: "gifdtgreen")
        containerView.addSubview(imageleft)
        
        let imageCenter = UIImageView()
        imageCenter.frame = CGRect(x: rw(170), y: textView.frame.maxY + rh(20), width: rw(35), height: rw(35))
        imageCenter.image = UIImage(named: "tag_green")
        containerView.addSubview(imageCenter)
        
        let imageRight = UIImageView()
        imageRight.frame = CGRect(x: rw(284), y: textView.frame.maxY + rh(20), width: rw(35), height: rw(35))
        imageRight.image = UIImage(named: "coin_green")
        containerView.addSubview(imageRight)
        
        let label1 = UILabel()
        label1.frame = CGRect(x: rw(21), y: imageCenter.frame.maxY + rh(8), width: rw(110), height: rh(19))
        label1.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        label1.font = UIFont(name: "Lato-Light", size: rw(16))
        label1.textAlignment = .center
        label1.text = "1 café par mois"
        containerView.addSubview(label1)
        
        let label2 = UILabel()
        label2.frame = CGRect(x: rw(133), y: imageCenter.frame.maxY + rh(8), width: rw(110), height: rh(19))
        label2.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        label2.font = UIFont(name: "Lato-Light", size: rw(16))
        label2.textAlignment = .center
        label2.text = "3%"
        containerView.addSubview(label2)
        

        let label3 = UILabel()
        label3.frame = CGRect(x: rw(247), y: imageCenter.frame.maxY + rh(8), width: rw(110), height: rh(19))
        label3.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        label3.font = UIFont(name: "Lato-Light", size: rw(16))
        label3.textAlignment = .center
        label3.text = "1.2x"
        containerView.addSubview(label3)
        
    }
    
    func setUpBottomButton(){
        let bottomButton = UIButton()
        bottomButton.frame = CGRect(x: rw(8), y: rh(595), width: rw(360), height: rh(55))
        bottomButton.backgroundColor = UIColor.white
        bottomButton.setTitle("Bonnifier mon abonnement", for: .normal)
        bottomButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        bottomButton.titleLabel?.font = UIFont(name: "Lato-Light", size: rw(22))
        bottomButton.addTarget(self, action: #selector(changeAbonnementPressed(sender:)), for: .touchUpInside)
        bottomButton.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        containerView.addSubview(bottomButton)
    }
    
    @objc func changeAbonnementPressed(sender:UIButton){
        performSegue(withIdentifier: "toListAbonnement", sender: nil)
    }

}


