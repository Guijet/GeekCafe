//
//  InfoHistory.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class InfoHistory: UIViewController {

    var structToPass:HistoryList!
    let scrollView = UIScrollView()
    let backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setNavigationTitle()
        setUpScrollView()
        fillScrollView()
        setUpBottomPart()
    }
    
    //To make bar all white non translucent and appearing
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Info Commande"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"Lato-Regular",size:rw(17))!, NSForegroundColorAttributeName:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: (view.frame.height - 64) - rh(123))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var newY:CGFloat = rh(10)
        if(structToPass.items.count > 0){
            for x in structToPass.items{
                let containerView = UIView()
                containerView.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: 80)
                containerView.backgroundColor = UIColor.clear
                scrollView.addSubview(containerView)
                
                let imageItem = UIImageView()
                imageItem.frame = CGRect(x: rw(15), y: rh(10), width: rw(60), height: rw(60))
                imageItem.image = x.image
                containerView.addSubview(imageItem)
                
                let price = UILabel()
                price.frame = CGRect(x: rw(260), y: (containerView.frame.height/2) - rh(10), width: rw(100), height: rh(20))
                price.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                price.font = UIFont(name: "Lato-Regular", size: rw(18))
                price.textAlignment = .right
                price.text = "$\(x.price)"
                containerView.addSubview(price)
                
                let flavour = UILabel()
                flavour.frame = CGRect(x: rw(85), y: ((containerView.frame.height/2) - rh(18)), width: price.frame.minX - rh(85), height: rh(18))
                flavour.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                flavour.font = UIFont(name: "Lato-Regular", size: rw(15))
                flavour.textAlignment = .left
                flavour.text = "\(x.flavour)"
                containerView.addSubview(flavour)
                
                let type = UILabel()
                type.frame = CGRect(x: rw(85), y: ((containerView.frame.height/2)), width: price.frame.minX - rh(85), height: rh(10))
                type.textColor = Utility().hexStringToUIColor(hex: "#D6D6D6")
                type.font = UIFont(name: "Lato-Regular", size: rw(13))
                type.textAlignment = .left
                type.text = "\(x.type)"
                containerView.addSubview(type)
                
                
                newY += (80 + rh(10))
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func setUpBottomPart(){
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: rh(554), width: view.frame.width, height: rh(113))
        bottomView.backgroundColor = Utility().hexStringToUIColor(hex: "#FBFBFB")
        bottomView.makeShadow(x: 0, y: 2, blur: 4, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.40, spread: 5)
        view.addSubview(bottomView)
        
        let date = UILabel()
        date.frame = CGRect(x: rw(20), y: rh(24), width: rw(172), height: rh(27))
        date.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        date.font = UIFont(name: "Lato-Regular", size: rw(22))
        date.textAlignment = .left
        date.text = structToPass.date
        bottomView.addSubview(date)
        
        let location = UILabel()
        location.frame = CGRect(x: rw(20), y: rh(51), width: rw(172), height: rh(14))
        location.textColor = Utility().hexStringToUIColor(hex: "#D6D6D6")
        location.font = UIFont(name: "Lato-Regular", size: rw(15))
        location.textAlignment = .left
        location.text = "\(structToPass.country), \(structToPass.city)"
        bottomView.addSubview(location)
        
        let buttonFacture = UIButton()
        buttonFacture.frame = CGRect(x: rw(20), y: rh(75), width: rw(108), height: rh(25))
        buttonFacture.setTitle("Voir la facture >", for: .normal)
        buttonFacture.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonFacture.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(15))
        buttonFacture.addTarget(self, action: #selector(seeBill), for: .touchUpInside)
        bottomView.addSubview(buttonFacture)
        
        let totalPrice = UILabel()
        totalPrice.frame = CGRect(x: rw(192), y: rh(16), width: rw(145), height: rh(32))
        totalPrice.textColor = Utility().hexStringToUIColor(hex: "#6CA642")
        totalPrice.font = UIFont(name: "Lato-Regular", size: rw(26))
        totalPrice.textAlignment = .right
        totalPrice.text = "$ 10.00"
        bottomView.addSubview(totalPrice)
        
        let priceAndTaxe = UILabel()
        priceAndTaxe.frame = CGRect(x: rw(192), y: rh(50), width: rw(145), height: rh(10))
        priceAndTaxe.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        priceAndTaxe.font = UIFont(name: "Lato-Light", size: rw(12))
        priceAndTaxe.textAlignment = .right
        priceAndTaxe.text = "$2.49 + $1.01"
        priceAndTaxe.sizeToFit()
        bottomView.addSubview(priceAndTaxe)
        
        let designTaxe = UILabel()
        designTaxe.frame = CGRect(x: rw(192), y: rh(65), width: rw(145), height: rh(10))
        designTaxe.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        designTaxe.font = UIFont(name: "Lato-Light", size: rw(12))
        designTaxe.textAlignment = .right
        designTaxe.text = "(TPS & TVQ)"
        designTaxe.sizeToFit()
        bottomView.addSubview(designTaxe)
        
        priceAndTaxe.frame.origin.x = (totalPrice.frame.maxX - priceAndTaxe.frame.width)
        designTaxe.center.x = priceAndTaxe.frame.midX
    }
    
    func seeBill(){
        print("See Bill Pressed")
    }

}







