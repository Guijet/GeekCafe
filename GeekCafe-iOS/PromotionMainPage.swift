//
//  PromotionMainPage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class PromotionMainPage: UIViewController,UIScrollViewDelegate {

    //Menu and container
    let menu = MenuClass()
    let containerView = UIView()
    var MetaPromotions:PromotionList!
    var arrayPromotions = [Promotion]()
    
    var isNext:Bool!
    var pageNumber = 1
    var nextString:String = ""
    
    //Pages element
    let backgroundImage = UIImageView()
    let scrollViewPromotion = UIScrollView()
    let popUpView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MetaPromotions =  APIRequestPromotion().getPromotions(page: "\(pageNumber)")
        arrayPromotions = MetaPromotions.promotions
        isNext = MetaPromotions.meta.isNext
        nextString = MetaPromotions.meta.nextString
        
        scrollViewPromotion.delegate = self
        //Menu and container
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Promotions")
        
        //Page set up
        //backgroundImage.setUpBackgroundImage(containerView: containerView)
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
    
    func fillScrollView(){
        if(arrayPromotions.count > 0){
            var newY:CGFloat = rw(8)
            for x in arrayPromotions{
                let backgroundCard = UIButton()
                backgroundCard.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(179))
                backgroundCard.backgroundColor = UIColor.white
                backgroundCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.30, spread: 0)
                backgroundCard.tag = x.id
                backgroundCard.addTarget(self, action: #selector(promoTapped(sender:)), for: .touchUpInside)
                scrollViewPromotion.addSubview(backgroundCard)
                
                let amount = UILabel()
                amount.frame = CGRect(x: rw(31), y: rh(40), width: rw(156), height: rh(80))
                amount.textColor = Utility().hexStringToUIColor(hex: "#6CA642")
                amount.text = "\(String(describing: x.reduction))"
                amount.textAlignment = .left
                amount.font = UIFont(name: "Lato-Bold", size: rw(70))
                backgroundCard.addSubview(amount)
                
                let labelItems = UILabel()
                labelItems.frame = CGRect(x: rw(31), y: amount.frame.maxY, width: rw(156), height: rh(11))
                labelItems.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                labelItems.text = "sur le \(x.itemName)"
                labelItems.textAlignment = .left
                labelItems.font = UIFont(name: "Lato-Light", size: rw(14))
                backgroundCard.addSubview(labelItems)
                
                let image = UIImageView()
                image.frame = CGRect(x: rw(190), y: rh(14.5), width: rw(150), height: rw(150))
                image.getOptimizeImageAsync(url: x.image_url)
                backgroundCard.addSubview(image)
                
                newY += rh(209)
            }
            scrollViewPromotion.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == scrollViewPromotion{
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height{
                if(isNext){
                    pageNumber += 1
                    getMorePromotions(pageNumber: pageNumber, stringRequest: nextString)
                }
                else{return}
            }
        }
    }
    
    func getMorePromotions(pageNumber:Int,stringRequest:String){
        let newMetaPagination = APIRequestPromotion().getPromotions(page: "\(pageNumber)", stringRequest: stringRequest)
        let newPromoArray = newMetaPagination.promotions
        nextString = newMetaPagination.meta.nextString
        isNext = newMetaPagination.meta.isNext
        for x in newPromoArray{
            arrayPromotions.append(x)
        }
        reloadScrollView()
    }
    
    func reloadScrollView(){
        for x in scrollViewPromotion.subviews{
            x.removeFromSuperview()
        }
        fillScrollView()
    }
    
    @objc func promoTapped(sender:UIButton){
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
    
    @objc func dismissCopyView(){
        
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
