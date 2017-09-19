//
//  MenuClass.swift
//  RightMenuTemplate
//
//  Created by Guillaume Jette on 2017-08-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//
import Foundation
import UIKit

class MenuClass{
    
    //
    //VISUAL ITEMS
    //
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
    //Menu buttons elements
    fileprivate let menuButtonsTitle = ["Accueil","Commander","Historique", "Abonnment","Trouvez un restaurant","Promotions"]
    //Deconnexion button
    fileprivate let deconnexionButton = UIButton()
    //Image deconnexion
    fileprivate let deconnexionImage = UIImageView()
    //Partial view for tap regognition
    fileprivate let closingView = UIView()
    //References to View in viewcontroller
    fileprivate var viewReferences = UIView()
    //View for all items of menu
    fileprivate let menuItemsContainer = UIView()
    //X position to go when animating
    fileprivate var xItemsAnimate:CGFloat = 0
    fileprivate var xPaleShadow:CGFloat = 0
    fileprivate var xHardShadow:CGFloat = 0
    
    //
    //ACTIONS
    //
    //Tap to close view
    fileprivate var closingGesture = UITapGestureRecognizer()
    //Swipe to close view
    fileprivate var closingSwipe = UISwipeGestureRecognizer()
    
    
    //
    //
    //Called when menu is pressed
    //
    //
    func triggerMenu(view:UIView){
        setVars(view:view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            view.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
            view.center.x -= self.movedX
            self.animateOpenItems(view: view)
        }, completion: nil)
    }
    
    private func setVars(view:UIView){
        xItemsAnimate = rw(161,view)
        addViewForClosingOnTap(view: view)
        viewReferences = view
        movedX = rw(255, viewReferences)
        view.makeShadow(x: 7, y: 0, blur: 22, cornerRadius: 8, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.12, spread: 0)
    }
    
    //
    //
    //
    //SETUP THE MENU VIEW
    //
    //
    func setUpMenu(view:UIView){
        
        closingWithSwipe(view: view)
        xHardShadow = rw(-100, view)
        shadowImageHard.frame = CGRect(x: rw(-100,view), y: rw(74, view), width: rw(270, view), height: rw(520, view))
        shadowImageHard.image = UIImage(named: "CardFonce")
        //view.addSubview(shadowImageHard)
        
        xPaleShadow = rw(-110, view)
        shadowImagePale.frame = CGRect(x: rw(-110, view), y: rw(53, view), width: rw(270, view), height: rw(560, view))
        shadowImagePale.image = UIImage(named: "CardPale")
        //view.addSubview(shadowImagePale)
        
        menuItemsContainer.frame = CGRect(x: rw(161,view) + view.frame.width, y: 0, width: view.frame.width - rw(161,view), height: view.frame.height)
        view.addSubview(menuItemsContainer)
        
        profileImage.frame = CGRect(x: 0, y: rw(91,view), width: rw(50,view), height: rw(50, view))
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.image = UIImage(named:"User")
        menuItemsContainer.addSubview(profileImage)
        
        name.frame = CGRect(x: rw(56,view), y: rw(104,view), width: (view.frame.width - profileImage.frame.maxY) - rw(15,view), height: rw(16,view))
        name.text = "Guillaume Jette"
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
        deconnexionButton.frame = CGRect(x: rw(27, view), y: rw(531,view), width: view.frame.width - rw(88, view) - rw(15, view), height: rw(12, view))
        deconnexionButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        deconnexionButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(14, view))
        deconnexionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        deconnexionButton.backgroundColor = UIColor.clear
        deconnexionButton.addTarget(self, action: #selector(MenuClass.logOutPressed), for: .touchUpInside)
        menuItemsContainer.addSubview(deconnexionButton)
        
        deconnexionImage.frame = CGRect(x: 0, y: rw(530, view), width: rw(12, view), height: rw(13, view))
        deconnexionImage.image = UIImage(named: "logoutIcon")
        menuItemsContainer.addSubview(deconnexionImage)
    }
    
    
    
    
    
    //Private function the close menu when the view is tapped
    //Need to add a view with UITapGestureRegognizer to close the menu
    @objc func closeMenu(sender: UITapGestureRecognizer){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            
            self.viewReferences.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.animateCloseItems(view: self.viewReferences)
            self.viewReferences.center.x += self.movedX
            
        }, completion: {_ in
            
            self.closingView.removeFromSuperview()
            
        })
        
    }
    
    //
    //
    //
    //Close tap gesture on view
    //
    //
    //
    func addViewForClosingOnTap(view:UIView){
        //Clicking on menu at left
        closingGesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu(sender:)))
        closingView.frame = view.frame
        closingView.addGestureRecognizer(closingGesture)
        view.addSubview(closingView)
    }
    
    //
    //
    //
    //Add swipe closing menu
    //
    //
    //
    func closingWithSwipe(view:UIView){
        closingSwipe = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        closingSwipe.direction = .right
        view.addGestureRecognizer(closingSwipe)
    }
    
    //
    //Action du logout
    //
    @objc fileprivate func logOutPressed(){
        print("Log Out")
    }
    
    private func animateOpenItems(view:UIView){
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.menuItemsContainer.frame.origin.x = self.xItemsAnimate
            //self.shadowImagePale.frame.origin.x = self.xPaleShadow
            //self.shadowImageHard.frame.origin.x = self.xHardShadow
        }, completion: { _ in
            view.isUserInteractionEnabled = true
        })
    }
    
    private func animateCloseItems(view:UIView){
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.menuItemsContainer.frame.origin.x = self.xItemsAnimate + view.frame.width
            //self.shadowImagePale.frame.origin.x = self.xPaleShadow + view.frame.width
            //self.shadowImageHard.frame.origin.x = self.xHardShadow + view.frame.width
        }, completion: { _ in
            view.isUserInteractionEnabled = true
        })
    }
    
    //When an items is selected
    @objc fileprivate func menuSelected(sender:UIButton){
        if(sender.tag == 1){
            
        }
        if(sender.tag == 2){
            
        }
        if(sender.tag == 3){
            
        }
        if(sender.tag == 4){
    
        }
        if(sender.tag == 5){
            
        }
        if(sender.tag == 6){
            
        }
    }
    
    //
    //
    //RATIO UI FUNCTION FOR VIEW PASSED
    //
    //
    func rw(_ val: CGFloat, _ view:UIView) -> CGFloat {
        return val * (view.frame.width / 375)
    }
    func rh(_ val: CGFloat, _ view:UIView) -> CGFloat {
        return val * (view.frame.height / 667)
    }
    
}
