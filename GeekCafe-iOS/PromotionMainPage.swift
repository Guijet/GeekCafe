//
//  PromotionMainPage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class PromotionMainPage: UIViewController {

    //Menu and container
    let menu = MenuClass()
    let containerView = UIView()
    var arrayPromotions = [Promotion]()
    
    //Pages element
    let backgroundImage = UIImageView()
    let scrollViewPromotion = UIScrollView()
    let popUpView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fake info array
        fillFakeInformation()
        
        //Menu and container
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Promotions")
        
        //Page set up
        backgroundImage.setUpBackgroundImage(containerView: containerView)
        setUpScrollView()
        fillScrollView()
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
        scrollViewPromotion.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollViewPromotion.backgroundColor = UIColor.clear
        scrollViewPromotion.showsVerticalScrollIndicator = false
        scrollViewPromotion.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollViewPromotion)
    }
    
    func fillFakeInformation(){
        arrayPromotions.append(Promotion(item: "café", discount: 50, image: UIImage(named:"test4")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "café", discount: 25, image: UIImage(named:"test4")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "café", discount: 10, image: UIImage(named:"test4")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "café", discount: 20, image: UIImage(named:"test4")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "café", discount: 70, image: UIImage(named:"test4")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "café", discount: 65, image: UIImage(named:"test4")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "café", discount: 30, image: UIImage(named:"test4")!, code: "12345678", id: 1))
    }
    
    func fillScrollView(){
        if(arrayPromotions.count > 0){
            var newY:CGFloat = rw(8)
            for x in arrayPromotions{
                let backgroundCard = UIButton()
                backgroundCard.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(179))
                backgroundCard.backgroundColor = UIColor.white
                backgroundCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor(white: 0.0, alpha: 0.12), shadowOpacity: 0.24, spread: 0)
                backgroundCard.tag = x.id
                backgroundCard.addTarget(self, action: #selector(promoTapped(sender:)), for: .touchUpInside)
                scrollViewPromotion.addSubview(backgroundCard)
                
                let amount = UILabel()
                amount.frame = CGRect(x: rw(31), y: rh(40), width: rw(156), height: rh(80))
                amount.textColor = Utility().hexStringToUIColor(hex: "#6CA642")
                amount.text = "\(String(x.discount))%"
                amount.textAlignment = .left
                amount.font = UIFont(name: "Lato-Bold", size: rw(70))
                backgroundCard.addSubview(amount)
                
                let labelItems = UILabel()
                labelItems.frame = CGRect(x: rw(31), y: amount.frame.maxY, width: rw(156), height: rh(11))
                labelItems.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                labelItems.text = "sur le \(x.item)"
                labelItems.textAlignment = .left
                labelItems.font = UIFont(name: "Lato-Light", size: rw(14))
                backgroundCard.addSubview(labelItems)
                
                let image = UIImageView()
                image.frame = CGRect(x: rw(190), y: rh(14.5), width: rw(150), height: rw(150))
                image.image = x.image
                backgroundCard.addSubview(image)
                
                newY += rh(188)
            }
            scrollViewPromotion.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func promoTapped(sender:UIButton){
        createCopyView()
        let promoCode = getPromoCodeByID(id: sender.tag)
        UIPasteboard.general.string = promoCode
    }
    
    func createCopyView(){
        disableEnableAllView(enable: false)
        popUpView.frame = CGRect(x: rw(113), y: rh(224), width: rw(145), height: rw(145))
        popUpView.backgroundColor = Utility().hexStringToUIColor(hex: "#F7F7F7")
        popUpView.makeShadow(x: 1, y: 2, blur: 2, cornerRadius: 10, shadowColor: Utility().hexStringToUIColor(hex: "#000000"), shadowOpacity: 0.06, spread: 1)
        popUpView.alpha = 1
        self.containerView.addSubview(popUpView)
        
        let imageSucces = UIImageView()
        imageSucces.frame = CGRect(x: rw(43), y: rh(19), width: rw(64), height: rw(64))
        imageSucces.image = UIImage(named: "copy_succes")
        popUpView.addSubview(imageSucces)
        
        let labelCopy = UILabel()
        labelCopy.frame = CGRect(x: 0, y: popUpView.bounds.maxY - rh(52), width: popUpView.frame.width, height: rh(30))
        labelCopy.textColor = Utility().hexStringToUIColor(hex: "#6CA642")
        labelCopy.text = "Copié"
        labelCopy.textAlignment = .center
        labelCopy.font = UIFont(name: "Lato-Light", size: rw(25))
        popUpView.addSubview(labelCopy)
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissCopyView), userInfo: nil, repeats: false)
    }
    
    func dismissCopyView(){
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.popUpView.removeFromSuperview()
            self.disableEnableAllView(enable: true)
        })
    }
    
    func getPromoCodeByID(id:Int)->String{
        var promoCode:String = ""
        if (arrayPromotions.count > 0){
            for x in arrayPromotions{
                if(x.id == id){
                    promoCode = x.code
                    break
                }
            }
        }
        return promoCode
    }
    
    func disableEnableAllView(enable:Bool){
        for x in scrollViewPromotion.subviews{
            if(enable){
                x.isUserInteractionEnabled = true
            }
            else{
                x.isUserInteractionEnabled = false
            }
        }
    }

}
