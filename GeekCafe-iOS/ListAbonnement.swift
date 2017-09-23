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
        fillFakeAbonnement()
        backgroundView.setUpBackgroundImage(containerView: self.view)
        setNavigationTitle()
        setUpScrollView()
        fillScrollView()
        
    }

    func fillFakeAbonnement(){
        arrAbonnements.append(Abonnement(id: 1, title: "Membre Premium", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", nbFreeCoffees: 7, percentage: 5, rationCoin: "1.5%"))
        arrAbonnements.append(Abonnement(id: 2, title: "Membre Spécial", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", nbFreeCoffees: 5, percentage: 3, rationCoin: "1.3%"))
        arrAbonnements.append(Abonnement(id: 3, title: "Membre Geek", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", nbFreeCoffees: 2, percentage: 2, rationCoin: "1.2%"))
        arrAbonnements.append(Abonnement(id: 4, title: "Membre Occasionel", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", nbFreeCoffees: 1, percentage: 1, rationCoin: "1.0%"))
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"Lato-Regular",size:rw(17))!, NSForegroundColorAttributeName:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }

    
    func fillScrollView(){
        var alpha:CGFloat = 1
        var newY = rh(28)
        var newYwhiteBut:CGFloat = rh(196)
        if(arrAbonnements.count > 0){
            for x in arrAbonnements{
                
                let container = UIView()
                container.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(179))
                container.backgroundColor = UIColor.clear
                scrollView.addSubview(container)
                
                let greenCard = UIButton()
                greenCard.frame = CGRect(x: 0, y: 0, width: rw(360), height: rh(179))
                greenCard.backgroundColor = UIColor(red: 22.0 / 255.0, green: 233.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0).withAlphaComponent(alpha)
                greenCard.tag = x.id
                greenCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
                greenCard.addTarget(self, action: #selector(performAnimationFlip(sender:)), for: .touchUpInside)
                
                let abonnementButtonWhite = UIButton()
                abonnementButtonWhite.frame = CGRect(x: 0, y: greenCard.frame.height - rh(65), width: rw(360), height: rh(65))
                abonnementButtonWhite.backgroundColor = UIColor.white.withAlphaComponent(0.80)
                abonnementButtonWhite.accessibilityIdentifier = "getPromo"
                abonnementButtonWhite.isHidden = true
                abonnementButtonWhite.addTarget(self, action: #selector(getAbonnement), for: .touchUpInside)
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
                alpha -= 0.20
    
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
            
            let textView = UILabel()
            textView.frame = CGRect(x: rw(16), y: rh(12), width: rw(330), height: rh(70))
            textView.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            textView.font = UIFont(name: "Lato-Light", size: rw(16))
            textView.textAlignment = .left
            textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
            textView.numberOfLines = 3
            textView.lineBreakMode = .byTruncatingHead
            textView.addCharactersSpacing(spacing: -0.85, text: textView.text!)
            sender.addSubview(textView)
            
            let imageleft = UIImageView()
            imageleft.frame = CGRect(x: rw(56), y: textView.frame.maxY + rh(20), width: rw(35), height: rw(35))
            imageleft.image = UIImage(named: "cup_white")
            sender.addSubview(imageleft)
            
            let imageCenter = UIImageView()
            imageCenter.frame = CGRect(x: rw(170), y: textView.frame.maxY + rh(20), width: rw(35), height: rw(35))
            imageCenter.image = UIImage(named: "tag_white")
            sender.addSubview(imageCenter)
            
            let imageRight = UIImageView()
            imageRight.frame = CGRect(x: rw(284), y: textView.frame.maxY + rh(20), width: rw(35), height: rw(35))
            imageRight.image = UIImage(named: "coin_white")
            sender.addSubview(imageRight)
            
            let label1 = UILabel()
            label1.frame = CGRect(x: rw(21), y: imageCenter.frame.maxY + rh(8), width: rw(110), height: rh(19))
            label1.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label1.font = UIFont(name: "Lato-Light", size: rw(16))
            label1.textAlignment = .center
            label1.text = "1 café par mois"
            sender.addSubview(label1)
            
            let label2 = UILabel()
            label2.frame = CGRect(x: rw(133), y: imageCenter.frame.maxY + rh(8), width: rw(110), height: rh(19))
            label2.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label2.font = UIFont(name: "Lato-Light", size: rw(16))
            label2.textAlignment = .center
            label2.text = "3%"
            sender.addSubview(label2)
            
            
            let label3 = UILabel()
            label3.frame = CGRect(x: rw(247), y: imageCenter.frame.maxY + rh(8), width: rw(110), height: rh(19))
            label3.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            label3.font = UIFont(name: "Lato-Light", size: rw(16))
            label3.textAlignment = .center
            label3.text = "1.2x"
            sender.addSubview(label3)
            
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

    func performAnimationFlip(sender:UIButton){
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
        var abonnment:Abonnement = Abonnement(id: 0, title: "", description: "", nbFreeCoffees: 0, percentage: 0, rationCoin: "")
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
    func getAbonnement(){
        
    }
}


