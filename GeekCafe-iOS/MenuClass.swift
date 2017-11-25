//
//  MenuClass.swift
//  RightMenuTemplate
//
//  Created by Guillaume Jette on 2017-08-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//
import Foundation
import UIKit
import FBSDKLoginKit

class MenuClass{
    
    //VISUAL ITEMS
    fileprivate var viewToAnimate = UIView()
    //Hard Shadow
    fileprivate let shadowImageHard = UIImageView()
    //Pale Shadoe
    fileprivate let shadowImagePale = UIImageView()
    //X movable animation variable
    fileprivate var movedX:CGFloat = 0
    //User info
    //Profile image
    fileprivate let profileImage = UIImageView()
    //Name
    fileprivate let name = UILabel()
    //Membership
    fileprivate let status = UILabel()
    //Credit
    fileprivate let LBL_Money = UILabel()
    fileprivate let LBL_CreditD = UILabel()
    
    //Menu buttons elements
    fileprivate let menuButtonsTitle = ["Accueil","Commander","Historique", "Abonnement","Trouvez un restaurant","Promotions","Paiements","Profil"]
    //Deconnexion button
    fileprivate let deconnexionButton = UIButton()
    //Image deconnexion
    fileprivate let deconnexionImage = UIImageView()
    //Partial view for tap regognition
    fileprivate let closingView = UIView()
    //View for all items of menu
    fileprivate let menuItemsContainer = UIView()
    //X position to go when animating
    fileprivate var xItemsAnimate:CGFloat = 0
    fileprivate var xPaleShadow:CGFloat = 0
    fileprivate var xHardShadow:CGFloat = 0
    fileprivate var isOpen:Bool = false
    fileprivate var menuButton = UIButton()
    
    //
    //ACTIONS
    //
    //Tap to close view
    fileprivate var closingGesture = UITapGestureRecognizer()
    //Swipe to close view
    fileprivate var closingSwipe = UISwipeGestureRecognizer()
    
    
    
    
    //
    //SETUP THE MENU VIEW
    //
    func setUpMenu(view:UIView){
        
        closingWithSwipe(view: view)
        
        menuItemsContainer.frame = CGRect(x: rw(161,view) + view.frame.width, y: 0, width: view.frame.width - rw(161,view), height: view.frame.height)
        view.addSubview(menuItemsContainer)
        
        profileImage.frame = CGRect(x: 0, y: rw(91,view), width: rw(50,view), height: rw(50, view))
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = true
        profileImage.getOptimizeImageAsync(url: Global.global.userInfo.image_url)
        menuItemsContainer.addSubview(profileImage)
        
        name.frame = CGRect(x: rw(56,view), y: rw(104,view), width: (view.frame.width - profileImage.frame.maxY) - rw(15,view), height: rw(16,view))
        name.text = "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)"
        name.textColor = Utility().hexStringToUIColor(hex: "#161616")
        name.textAlignment = .left
        name.font = UIFont(name: "Lato-Regular", size: rw(13, view))
        menuItemsContainer.addSubview(name)
        
        status.frame = CGRect(x: rw(56,view), y: rw(121,view), width: (view.frame.width - profileImage.frame.maxY) - rw(15,view), height: rw(12,view))
        status.text = "Coffee Addicted Pro"
        status.textColor = Utility().hexStringToUIColor(hex: "#6CA643")
        status.textAlignment = .left
        status.font = UIFont(name: "Lato-Regular", size: rw(10,view))
        menuItemsContainer.addSubview(status)
        
        LBL_Money.createLabel(frame: CGRect(x:status.frame.minX,y:status.frame.maxY + rh(3,view),width:rw(100, view),height:rh(11,view)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(9,view), textAignment: .left, text: "10.00$")
        LBL_Money.sizeToFit()
        menuItemsContainer.addSubview(LBL_Money)
        
        LBL_CreditD.createLabel(frame: CGRect(x:LBL_Money.frame.maxX + rw(3,view),y:status.frame.maxY + rh(4,view),width:rw(100, view),height:rh(11,view)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Light", fontSize: rw(7,view), textAignment: .left, text: "crédit disponible")
        menuItemsContainer.addSubview(LBL_CreditD)
        
        var newY = rw(204, view)
        var index = 1
        
        for x in menuButtonsTitle{
            
            let button = UIButton()
            button.setTitle(x, for: .normal)
            button.frame = CGRect(x: 0, y: newY, width: view.frame.width - rw(88,view) - rw(15,view), height: rw(14,view))
            button.setTitleColor(Utility().hexStringToUIColor(hex: "#6E6E6E"), for: .normal)
            button.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(18,view))
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(MenuClass.menuSelected(sender:)), for: .touchUpInside)
            button.tag = index
            menuItemsContainer.addSubview(button)
            
            index += 1
            newY += rw(43,view)
        }
        
        deconnexionButton.setTitle("Déconnexion", for: .normal)
        deconnexionButton.frame = CGRect(x: rw(27, view), y: rw(548,view), width: view.frame.width - rw(88, view) - rw(15, view), height: rw(12, view))
        deconnexionButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        deconnexionButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(14, view))
        deconnexionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        deconnexionButton.backgroundColor = UIColor.clear
        deconnexionButton.addTarget(self, action: #selector(MenuClass.logOutPressed), for: .touchUpInside)
        menuItemsContainer.addSubview(deconnexionButton)
        
        deconnexionImage.frame = CGRect(x: 0, y: rw(546, view), width: rw(12, view), height: rw(13, view))
        deconnexionImage.image = UIImage(named: "logoutIcon")
        menuItemsContainer.addSubview(deconnexionImage)
    }
    
    func updateImageProfile(){
        profileImage.image = Utility().getOptimizeImage(url: Global.global.userInfo.image_url)
    }
    
    func setUpFakeNavBar(view:UIView,titleTop:String){
        
        viewToAnimate = view
        
        let fakeBar = UIView()
        fakeBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        fakeBar.accessibilityIdentifier = "NavBarFake"
        fakeBar.backgroundColor = UIColor.white
        view.addSubview(fakeBar)
        
        Utility().createHR(x: 0, y: fakeBar.frame.height - 1, width: view.frame.width, view: fakeBar, color: Utility().hexStringToUIColor(hex: "#DCDCDC"))
        
        let geekIcon = UIButton(type: .system)
        geekIcon.tintColor = Utility().hexStringToUIColor(hex: "#6CA743")
        geekIcon.setImage(#imageLiteral(resourceName: "menuLeftImage"),for:.normal)
        geekIcon.frame = CGRect(x: 18, y: fakeBar.frame.height/1.5 - 16, width: 22, height: 28)
        fakeBar.addSubview(geekIcon)
        
        
        menuButton = UIButton(type:.system)
        menuButton.frame = CGRect(x: view.frame.width - 40, y: fakeBar.frame.height/1.5 - 17, width: 34, height: 34)
        menuButton.tintColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        menuButton.setImage(#imageLiteral(resourceName: "open_menu"),for:.normal)
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        menuButton.addTarget(self, action: #selector(triggerMenu), for: .touchUpInside)
        fakeBar.addSubview(menuButton)
        
        let title = UILabel()
        title.frame = CGRect(x: (view.frame.width/2 - rw(100,view)), y: (menuButton.frame.midY) - rh(12,view), width: rw(200,view), height: rh(20,view))
        title.text = titleTop
        title.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        title.textAlignment = .center
        title.font = UIFont(name: "Lato-Regular", size: rw(17,view))
        fakeBar.addSubview(title)
    }
    
    //
    //Called when menu is pressed
    //
    @objc private func triggerMenu(){
        setVars(view:viewToAnimate)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.viewToAnimate.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
            self.viewToAnimate.center.x -= self.movedX
            self.animateOpenItems(view: self.viewToAnimate)
        }, completion: { _ in
            self.isOpen = true
        })
    }
    
    //
    //Preparing animations variables when triggering menu
    //
    private func setVars(view:UIView){
        xItemsAnimate = rw(161,view)
        addViewForClosingOnTap(view: view)
        movedX = rw(255, viewToAnimate)
        view.makeShadow(x: 7, y: 0, blur: 22, cornerRadius: 8, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.12, spread: 0)
    }
    
    //
    //Private function the close menu when the view is tapped
    //Need to add a view with UITapGestureRegognizer to close the menu
    //
    @objc private func closeMenu(){
        if(isOpen){
            self.closingSwipe.removeTarget(self, action: #selector(closeMenu))
            self.viewToAnimate.isUserInteractionEnabled = false
            self.closingView.removeFromSuperview()
            self.closingView.removeFromSuperview()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.viewToAnimate.center.x += self.movedX
                self.animateCloseItems(view: self.viewToAnimate)
            }, completion: {_ in
                self.closingView.removeFromSuperview()
                self.isOpen = false
                self.viewToAnimate.isUserInteractionEnabled = true
                self.closingSwipe.addTarget(self, action: #selector(self.closeMenu))
            })
        }
    }
    
    //When an items is selected
    @objc fileprivate func menuSelected(sender:UIButton){
    
        if(sender.tag == 1){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "DashMain"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "DashMain")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
        
        if(sender.tag == 2){
            
            if(Global.global.userInfo.cards.count > 0){
                if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "CommmandeMainPage"{
                    closeMenu()
                    return
                }
                closeMenu()
                DispatchQueue.global().async {
                    while self.isOpen{usleep(500)}
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Commande", bundle: nil)
                        let main = storyboard.instantiateViewController(withIdentifier: "CommmandeMainPage")
                        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            UIApplication.shared.keyWindow?.rootViewController = main
                        }, completion: nil)
                    }
                }
            }
            else{
                Utility().alertWithChoice(message: "You currently have no payment method. You will only be able to order at the counter. Would you like to continue?", title: "Message", control: (UIApplication.shared.keyWindow?.rootViewController!)!, actionTitle1: "Continue", actionTitle2: "Add payment method", action1: {
                    if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "CommmandeMainPage"{
                        self.closeMenu()
                        return
                    }
                    self.closeMenu()
                    DispatchQueue.global().async {
                        while self.isOpen{usleep(500)}
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Commande", bundle: nil)
                            let main = storyboard.instantiateViewController(withIdentifier: "CommmandeMainPage")
                            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                UIApplication.shared.keyWindow?.rootViewController = main
                            }, completion: nil)
                        }
                    }
                }, action2: {
                    if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "MainCredit"{
                        self.closeMenu()
                        return
                    }
                    self.closeMenu()
                    DispatchQueue.global().async {
                        while self.isOpen{usleep(500)}
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Credits", bundle: nil)
                            let main = storyboard.instantiateViewController(withIdentifier: "MainCredit")
                            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                UIApplication.shared.keyWindow?.rootViewController = main
                            }, completion: nil)
                        }
                    }
                
                }, style: UIAlertControllerStyle.alert)
            }
            
        }
        if(sender.tag == 3){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "HistoriqueMainPage"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Historique", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "HistoriqueMainPage")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
        if(sender.tag == 4){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "AbonnementMain"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Abonnement", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "AbonnementMain")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
        if(sender.tag == 5){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "FindRestoMainPage"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "TrouverRestau", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "FindRestoMainPage")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
        if(sender.tag == 6){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "PromotionMainPage"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Promotions", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "PromotionMainPage")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
        
        if(sender.tag == 7){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "MainCredit"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Credits", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "MainCredit")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
        
        if(sender.tag == 8){
            if UIApplication.shared.keyWindow?.rootViewController?.restorationIdentifier == "ProfileMainPage"{
                closeMenu()
                return
            }
            closeMenu()
            DispatchQueue.global().async {
                while self.isOpen{usleep(500)}
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "ProfileMainPage")
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = main
                    }, completion: nil)
                }
            }
        }
    }
    
    
    
    //
    //Close tap gesture on view
    //
    func addViewForClosingOnTap(view:UIView){
        //Clicking on menu at left
        closingGesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        closingView.frame = view.frame
        closingView.addGestureRecognizer(closingGesture)
        view.addSubview(closingView)
    }
    
    //
    //Add swipe closing menu
    //
    func closingWithSwipe(view:UIView){
        closingSwipe = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        closingSwipe.direction = .right
        view.addGestureRecognizer(closingSwipe)
    }
    
    private func animateOpenItems(view:UIView){
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.menuItemsContainer.frame.origin.x = self.xItemsAnimate
        }, completion: { _ in
            view.isUserInteractionEnabled = true
        })
    }
    
    //
    //Action du logout
    //
    @objc fileprivate func logOutPressed(){
        Utility().alertYesNo(message: "Ëtes-vous certain de vouloir vous déconnecter?", title: "Message", control: viewToAnimate.parentViewController!, yesAction: {
            UserDefaults.standard.removeObject(forKey: "Token")
            UserDefaults.standard.removeObject(forKey: "FB_Token")
            if(Global.global.isFbUser){
                FBSDKLoginManager().logOut()
            }
            self.clearGlobals()
            let storyboard = UIStoryboard(name: "LoginV2", bundle: nil)
            let main = storyboard.instantiateViewController(withIdentifier: "MainPageLoginV2")
            UIApplication.shared.keyWindow?.rootViewController = main
        }, noAction: nil, titleYes: "Continuer", titleNo: "Annuler", style: .alert)
    }
    
    func clearGlobals(){
        Global.global.fbResult = ""
        Global.global.userInfo = User(firstname: "", lastname: "", email: "", sexe: "", birthdate: "", phone: "", id: 0, image_url: "", token: "", id_subscription: 0,points: 0, cards: [userCard]())
        Global.global.itemsOrder = [itemOrder]()
        Global.global.isFbUser = false
    }
    
    private func animateCloseItems(view:UIView){
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.menuItemsContainer.frame.origin.x = self.xItemsAnimate + view.frame.width
        }, completion: { _ in
            view.isUserInteractionEnabled = true
        })
    }

    //
    //RATIO UI FUNCTION FOR VIEW PASSED
    //
    func rw(_ val: CGFloat, _ view:UIView) -> CGFloat {
        return val * (view.frame.width / 375)
    }
    func rh(_ val: CGFloat, _ view:UIView) -> CGFloat {
        return val * (view.frame.height / 667)
    }
    
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
