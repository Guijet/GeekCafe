//
//  MainPageCredit.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class MainPageCredit: UIViewController {

    let menu = MenuClass()
    var arrayCards = [userCard]()
    let scrollView = UIScrollView()
    let containerView = UIView()
    let load = loadingIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos: .background).async {
            self.arrayCards = APIRequestLogin().indexPaymentsMethod(cardHolderName: "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)")
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
        let buttonAddCard = UIButton()
        buttonAddCard.frame = CGRect(x: 0, y: rh(601), width: view.frame.width, height: rh(66))
        buttonAddCard.backgroundColor = UIColor.white
        buttonAddCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        buttonAddCard.setTitle("Changer ma carte", for: .normal)
        buttonAddCard.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonAddCard.addTarget(self, action: #selector(addCard), for: .touchUpInside)
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
    }
    
    func getCardByID(){
        
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
    
    func deleteCardAnimation(sender:UIButton){
        if(!isOpen(view: sender.superview!)){
            openButtonDelete(superView: sender.superview!,sender: sender)
        }
        else{
            
            removeDeleteButton(container: sender.superview!)
        }
    }
    
    func deleteCard(sender:UIButton){
        
    }
    
    func addCard(){
        
    }

    
}
