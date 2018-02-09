//
//  MainPageProfile.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class MainPageProfile: UIViewController {

    let menu = MenuClass()
    let containerView = UIView()
    let scrollView = UIScrollView()
    let profileImage = UIImageView()
    let backgroundImage = UIImageView()
    let switchNotif = UISwitch()
    var titleOptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Global.global.isFbUser){
            titleOptions = ["Notification Push","Évaluez notre application","Termes et conditions","Paiements"]
        }
        else{
            titleOptions = ["Notification Push","Modifier mon profil","Évaluez notre application","Termes et conditions","Paiements"]
        }
        //Menu and container
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Profil")
        
        //Set Up Page
        setUpScrollView()
        setUpTopView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollView)
        
    }
    
    func setUpTopView(containerView:UIView){
        
        profileImage.frame = CGRect(x: rw(133), y: rh(36), width: rw(111), height: rw(111))
        profileImage.layer.cornerRadius = rw(111)/2
        profileImage.getOptimizeImageAsync(url: Global.global.userInfo.image_url)
        profileImage.layer.masksToBounds = true
        containerView.addSubview(profileImage)
        
        let name = UILabel()
        name.createLabel(frame: CGRect(x:rw(50),y:profileImage.frame.maxY + rh(10),width:view.frame.width - rw(100),height:rh(30)), textColor: Utility().hexStringToUIColor(hex:"#161616"), fontName: "Lato-Regular", fontSize: rw(25), textAignment: .center, text: "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)")
        name.adjustsFontSizeToFitWidth = true
        containerView.addSubview(name)
        
        let subscription = UILabel()
        subscription.createLabel(frame: CGRect(x:rw(50),y:name.frame.maxY,width:view.frame.width - rw(100),height:rh(22)), textColor: Utility().hexStringToUIColor(hex:"#6CA642"), fontName: "Lato-Regular", fontSize: rw(18), textAignment: .center, text: "\(Global.global.userInfo.abonnement.title)")
        containerView.addSubview(subscription)
    
        let buttonChangeSub = UIButton()
        buttonChangeSub.frame = CGRect(x: rw(60), y: subscription.frame.maxY, width: view.frame.width - rw(120), height: rh(20))
        buttonChangeSub.setTitle("Gérer mon abonnement", for: .normal)
        buttonChangeSub.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonChangeSub.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(12))
        buttonChangeSub.addTarget(self, action: #selector(changeSub), for: .touchUpInside)
        containerView.addSubview(buttonChangeSub)
        
        let LBL_CreditD = UILabel()
        LBL_CreditD.createLabel(frame: CGRect(x:view.frame.width - rw(50),y:buttonChangeSub.frame.maxY + rh(14),width:rw(40),height:rh(24)), textColor: Utility().hexStringToUIColor(hex:"#CDCDCD"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "Points")
        containerView.addSubview(LBL_CreditD)
        
        let LBL_Money = UILabel()
        LBL_Money.createLabel(frame: CGRect(x:(LBL_CreditD.frame.minX - (view.frame.width/2)) - rw(5),y:LBL_CreditD.frame.minY - rh(4),width:view.frame.width/2,height:rh(24)), textColor: Utility().hexStringToUIColor(hex:"#CDCDCD"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: "\(Global.global.userInfo.points)")
        containerView.addSubview(LBL_Money)
        
    }

    func setUpTopView(){
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(270))
        topView.backgroundColor = UIColor.white
        topView.makeShadow(x: 0, y: 2, blur: 14, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        
        setUpTopView(containerView:topView)
        
        var newY:CGFloat = topView.frame.maxY
        var index:Int = 1
        
        for x in titleOptions{
            
            let buttonContainer = UIButton()
            buttonContainer.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: rh(82))
            buttonContainer.backgroundColor = UIColor.white
            buttonContainer.tag = index
            buttonContainer.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            scrollView.addSubview(buttonContainer)
            
            let title = UILabel()
            title.createLabel(frame: CGRect(x:rw(14),y:rh(32),width:rw(250),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#303841"), fontName: "Lato-Regular", fontSize: rw(16), textAignment: .left, text: x)
            buttonContainer.addSubview(title)
            
            if(index == 1){
                
                switchNotif.frame = CGRect(x: view.frame.maxX - 82, y: buttonContainer.frame.height/2 - 15, width: 50, height: 30)
                //switchNotif.isUserInteractionEnabled = false
                switchNotif.backgroundColor = Utility().hexStringToUIColor(hex: "#E7E8E9")
                switchNotif.onTintColor = Utility().hexStringToUIColor(hex: "#7ED321")
                switchNotif.layer.cornerRadius = 16
                switchNotif.layer.borderWidth = 0.7
                switchNotif.layer.borderColor = Utility().hexStringToUIColor(hex: "#C7C7C7").cgColor
                Utility().createOverTapListener(x: switchNotif.frame.minX, y: switchNotif.frame.minY, width: switchNotif.frame.width, height: switchNotif.frame.height, view: buttonContainer, selector:#selector(switchValueDidChange) )
                buttonContainer.addSubview(switchNotif)
            }
            else{
                let fleche = UIImageView()
                fleche.frame = CGRect(x: rw(328), y: rh(30), width: rw(20), height: rw(20))
                fleche.image = #imageLiteral(resourceName: "rightArrow")
                fleche.contentMode = .scaleAspectFit
                buttonContainer.addSubview(fleche)
                
            }
            
            Utility().createHR(x: 0, y: buttonContainer.bounds.maxY - 1, width: view.frame.width, view: buttonContainer, color: Utility().hexStringToUIColor(hex: "#E7E8E9"))
            
            index += 1
            newY += rh(82)
        }
        scrollView.addSubview(topView)
        scrollView.contentSize = CGSize(width: 1.0, height: newY)
    }
    
    @objc func switchValueDidChange(sender:UISwitch!) {
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    @objc func changeSub(){
        let storyboard = UIStoryboard(name: "Abonnement", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "AbonnementMain")
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.keyWindow?.rootViewController = main
        }, completion: nil)
    }
    
    @objc func buttonPressed(sender:UIButton){
        if(!Global.global.isFbUser){
            if(sender.tag == 2){
                performSegue(withIdentifier: "toModifyProfile", sender: nil)
            }
            else if(sender.tag == 3){
                performSegue(withIdentifier: "toRatings", sender: nil)
            }
            else if(sender.tag == 4){
                performSegue(withIdentifier: "toTermsAndCondition", sender: nil)
            }
            else if(sender.tag == 5){
                let storyboard = UIStoryboard(name: "Credits", bundle: nil)
                let main = storyboard.instantiateViewController(withIdentifier: "MainCredit")
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    UIApplication.shared.keyWindow?.rootViewController = main
                }, completion: nil)
            }
        }
        else if(Global.global.isFbUser){
            if(sender.tag == 2){
                performSegue(withIdentifier: "toRatings", sender: nil)
            }
            else if(sender.tag == 3){
                performSegue(withIdentifier: "toTermsAndCondition", sender: nil)
            }
            else if(sender.tag == 4){
                let storyboard = UIStoryboard(name: "Credits", bundle: nil)
                let main = storyboard.instantiateViewController(withIdentifier: "MainCredit")
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    UIApplication.shared.keyWindow?.rootViewController = main
                }, completion: nil)
            }
        }
        
    }
    
}
