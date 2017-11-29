//
//  ListAbonnement.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-22.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class ListAbonnement: UIViewController {
    
    let scrollView = UIScrollView()
    let backgroundView = UIImageView()
    var arrAbonnements = [Abonnement]()
    
    //Detail View
    let viewContainerDetail = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        arrAbonnements = APIRequestAbonnement().getAllAbonnement()
        removeCurrentSubFromlist()
        backgroundView.setUpBackgroundImage(containerView: self.view)
        setNavigationTitle()
        setUpScrollView()
        fillScrollView()
        
    }
    
    func removeCurrentSubFromlist(){
        if(arrAbonnements.count > 0){
            var index = 0
            for x in arrAbonnements{
                if(x.id == Global.global.userInfo.abonnement.id){
                    arrAbonnements.remove(at: index)
                }
                index += 1
            }
        }
    }
    
    //To make bar all white non translucent and appearing
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Liste Abonnements"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }

    
    func fillScrollView(){
       
        var newY = rh(28)
        var newYwhiteBut:CGFloat = rh(196)
        
        if(arrAbonnements.count > 0){
            for x in arrAbonnements{
                
                let container = UIView()
                container.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(179))
                container.backgroundColor = UIColor.clear
                container.tag = x.id
                scrollView.addSubview(container)
             
                let greenCard = UIButton()
                greenCard.frame = CGRect(x: 0, y: 0, width: rw(360), height: rh(179))
                //greenCard.backgroundColor = UIColor(red: 22.0 / 255.0, green: 233.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0).withAlphaComponent(alpha)
                greenCard.tag = x.id
                greenCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
                greenCard.addTarget(self, action: #selector(performAnimationFlip(sender:)), for: .touchUpInside)
                
                let gradient = CAGradientLayer()
                gradient.frame = greenCard.bounds
                gradient.cornerRadius = 8
                gradient.colors = [Utility().hexStringToUIColor(hex: "15EA6D").cgColor, Utility().hexStringToUIColor(hex: "#16E9A6").cgColor]
                greenCard.layer.insertSublayer(gradient, at: 0)
                
                let abonnementButtonWhite = UIButton()
                abonnementButtonWhite.frame = CGRect(x: 0, y: greenCard.frame.height - rh(65), width: rw(360), height: rh(65))
                abonnementButtonWhite.backgroundColor = UIColor.white.withAlphaComponent(0.80)
                abonnementButtonWhite.accessibilityIdentifier = "getPromo"
                abonnementButtonWhite.isHidden = true
                abonnementButtonWhite.addTarget(self, action: #selector(getAbonnement(sender:)), for: .touchUpInside)
                abonnementButtonWhite.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
                
                let titleInButton = UILabel()
                titleInButton.createLabel(frame: CGRect(x: 0, y: rh(27), width: abonnementButtonWhite.frame.width, height: rh(26)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Light", fontSize: rw(22), textAignment: .center, text: "Adhérer à cet abonnement")
                abonnementButtonWhite.addSubview(titleInButton)
               
                let logoBackGroundCard = UIImageView()
                logoBackGroundCard.frame = CGRect(x: rw(249), y: rh(16), width: rw(111), height: rh(163))
                logoBackGroundCard.image = UIImage(named: "geekAboonmentCard")
                
                let titleMember = UILabel()
                titleMember.createLabel(frame: CGRect(x: rw(20), y: rh(60), width: rw(184), height: rh(22)), textColor: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Regular", fontSize: rw(18), textAignment: .left, text: x.title)
                
                let imageBrandText = UIImageView()
                imageBrandText.frame = CGRect(x: rw(20), y: rh(83), width: rw(184), height: rh(33))
                imageBrandText.image = UIImage(named: "titleAbonnementCard")
                
                container.addSubview(abonnementButtonWhite)
                container.addSubview(greenCard)
                greenCard.addSubview(logoBackGroundCard)
                greenCard.addSubview(titleMember)
                greenCard.addSubview(imageBrandText)
                
                newY += rh(206)
                newYwhiteBut += (184)
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func isOpen(view:UIView)->Bool{
        return view.frame.height > rh(179)
    }
    
    func updateGreenCard(sender:UIButton){
        let x = getAbonnementBYID(id: sender.tag)
        if(!isOpen(view: sender.superview!)){
            
            self.moveAllDown(yAt:(sender.superview?.frame.minY)!)
            
            for x in sender.subviews{
                x.removeFromSuperview()
            }
            
            //DESCRIPTION
            let textView = UILabel()
            textView.frame = CGRect(x: rw(16), y: rh(5), width: rw(330), height: rh(70))
            textView.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            textView.font = UIFont(name: "Lato-Light", size: rw(16))
            textView.textAlignment = .left
            textView.text = x.description
            textView.numberOfLines = 3
            textView.lineBreakMode = .byTruncatingHead
            textView.addCharactersSpacing(spacing: -0.85, text: textView.text!)
            sender.addSubview(textView)
            
            //PERKS
            let image1 = UIImageView()
            image1.frame = CGRect(x: rw(36), y: textView.frame.maxY + rh(12), width: rw(33), height: rw(33))
            image1.image = UIImage(named: "gift")
            sender.addSubview(image1)
            
            //% RABAIS
            let image2 = UIImageView()
            image2.frame = CGRect(x: rw(119), y: textView.frame.maxY + rh(12), width: rw(33), height: rw(33))
            image2.image = UIImage(named: "tag_white")
            sender.addSubview(image2)
            
            //RATIO POINTS
            let image3 = UIImageView()
            image3.frame = CGRect(x: rw(207), y: textView.frame.maxY + rh(12), width: rw(33), height: rw(33))
            image3.image = UIImage(named: "coin_white")
            sender.addSubview(image3)
            
            //PRICE
            let image4 = UIImageView()
            image4.frame = CGRect(x: rw(296), y: textView.frame.maxY + rh(12), width: rw(33), height: rw(33))
            image4.image = UIImage(named: "dollarsign")
            sender.addSubview(image4)
            
            //PERKS
            let label1 = UILabel()
            label1.frame = CGRect(x: rw(6), y: image2.frame.maxY + rh(4), width: rw(90), height: rh(40))
            label1.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label1.font = UIFont(name: "Lato-Light", size: rw(16))
            label1.textAlignment = .center
            label1.text = x.perk
            label1.numberOfLines = 2
            sender.addSubview(label1)
            
            //% RABAIS
            let label2 = UILabel()
            label2.frame = CGRect(x: rw(95), y: image2.frame.maxY + rh(12), width: rw(80), height: rh(19))
            label2.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label2.font = UIFont(name: "Lato-Light", size: rw(16))
            label2.textAlignment = .center
            label2.text = "\(x.discount)%"
            sender.addSubview(label2)
            
            //RATIO POINTS
            let label3 = UILabel()
            label3.frame = CGRect(x: rw(184), y: image2.frame.maxY + rh(12), width: rw(80), height: rh(19))
            label3.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label3.font = UIFont(name: "Lato-Light", size: rw(16))
            label3.textAlignment = .center
            label3.text = "\(x.point_reward)x"
            sender.addSubview(label3)
            
            //PRICE
            let label4 = UILabel()
            label4.frame = CGRect(x: rw(273), y: image2.frame.maxY + rh(12), width: rw(80), height: rh(18))
            label4.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label4.font = UIFont(name: "Lato-Light", size: rw(16))
            label4.textAlignment = .center
            label4.text = "\(x.price.floatValue.twoDecimal)$/mois"
            label4.adjustsFontSizeToFitWidth = true
            sender.addSubview(label4)
            
            sender.superview?.frame.size.height += rh(50)
            
            for x in (sender.superview?.subviews)!{
                if(x.accessibilityIdentifier == "getPromo"){
                    x.isHidden = false
                    x.frame.origin.y += rh(50)
                }
            }
            
        }
        else{
            self.moveAllViewUp(yAt:(sender.superview?.frame.minY)!)
            for x in sender.subviews{
                x.removeFromSuperview()
            }
            
            
            let logoBackGroundCard = UIImageView()
            logoBackGroundCard.frame = CGRect(x: rw(249), y: rh(16), width: rw(111), height: rh(163))
            logoBackGroundCard.image = UIImage(named: "geekAboonmentCard")
            
            let titleMember = UILabel()
            titleMember.createLabel(frame: CGRect(x: rw(20), y: rh(60), width: rw(184), height: rh(22)), textColor: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Regular", fontSize: rw(18), textAignment: .left, text: x.title)
            
            let imageBrandText = UIImageView()
            imageBrandText.frame = CGRect(x: rw(20), y: rh(83), width: rw(184), height: rh(33))
            imageBrandText.image = UIImage(named: "titleAbonnementCard")

            sender.addSubview(logoBackGroundCard)
            sender.addSubview(titleMember)
            sender.addSubview(imageBrandText)
            
            sender.superview?.frame.size.height -= rh(50)
            
            for x in (sender.superview?.subviews)!{
                if(x.accessibilityIdentifier == "getPromo"){
                    x.isHidden = true
                    x.frame.origin.y -= rh(50)
                }
            }
            
        }
    }

    @objc func performAnimationFlip(sender:UIButton){
        //ANIMATION DE FLIP POUR LE BOUTON
        UIView.transition(with: sender, duration: 0.8, options: [.transitionFlipFromBottom,.showHideTransitionViews], animations: {
            self.updateGreenCard(sender:sender)
        }, completion: { _ in
            
        })
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
    
    //Get abonnement by id
    func getAbonnementBYID(id:Int)->Abonnement{
        var abonnment:Abonnement = Abonnement(id: 0, title: "", description: "", perk: "", point_reward: 0, discount: 0, price: 0 as NSNumber)
        if(arrAbonnements.count > 0){
            for x in arrAbonnements{
                if(x.id == id){
                    abonnment = x
                    break
                }
            }
        }
        return abonnment
    }

    //Aderer a l'abonnement
    @objc func getAbonnement(sender:UIButton){
        APIRequestAbonnement().modifyAbonnement(id_sub: sender.superview!.tag)
        _ = self.navigationController?.popViewController(animated: true)
    }
}


