//
//  InfoHistory.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class InfoHistory: UIViewController {

    var idToPass:Int!
    let scrollView = UIScrollView()
    var arrayItems = [itemInfo]()
    var historyToPass:HistoryList!
    let backgroundImage = UIImageView()
    var priceAllItems:Float = 0
    let bottomView = UIView()
    let designTaxe = UILabel()
    let loading = loadingIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global().async {
            self.arrayItems = APIRequestHistory().getItemFromOrderID(id: self.idToPass)
            if #available(iOS 11.0, *) {
                self.scrollView.contentInsetAdjustmentBehavior = .automatic
            } else {}
            DispatchQueue.main.async {
                self.backgroundImage.setUpBackgroundImage(containerView: self.view)
                self.setNavigationTitle()
                self.setUpScrollView()
                self.fillScrollView()
                self.setUpBottomPart()
                self.addLBLSaved()
                self.loading.stopAnimatingAndRemove(view: self.view)
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
        self.title = "Info Commande"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
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
        if(arrayItems.count > 0){
            for x in arrayItems{
                let containerView = UIView()
                containerView.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: 80)
                containerView.backgroundColor = UIColor.clear
                scrollView.addSubview(containerView)

                let imageItem = UIImageView()
                imageItem.frame = CGRect(x: rw(15), y: rh(10), width: rw(60), height: rw(60))
                imageItem.getOptimizeImageAsync(url: x.image_url)
                imageItem.contentMode = .scaleAspectFit
                containerView.addSubview(imageItem)

                let price = UILabel()
                price.frame = CGRect(x: rw(260), y: (containerView.frame.height/2) - rh(10), width: rw(100), height: rh(20))
                price.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                price.font = UIFont(name: "Lato-Regular", size: rw(18))
                price.textAlignment = .right
                let totalItemPrice:Float = (x.price.floatValue + x.subItemsPrice.floatValue)
                price.text = "$\(totalItemPrice.twoDecimal)"
                priceAllItems += totalItemPrice
                containerView.addSubview(price)

                let flavour = UILabel()
                flavour.frame = CGRect(x: rw(85), y: ((containerView.frame.height/2) - rh(18)), width: price.frame.minX - rh(85), height: rh(18))
                flavour.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                flavour.font = UIFont(name: "Lato-Regular", size: rw(15))
                flavour.textAlignment = .left
                flavour.text = "\(x.name)"
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
        
        bottomView.frame = CGRect(x: 0, y: rh(554), width: view.frame.width, height: rh(113))
        bottomView.backgroundColor = Utility().hexStringToUIColor(hex: "#FBFBFB")
        bottomView.makeShadow(x: 0, y: 2, blur: 4, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.40, spread: 5)
        view.addSubview(bottomView)
        
        let date = UILabel()
        date.frame = CGRect(x: rw(20), y: rh(24), width: rw(172), height: rh(27))
        date.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        date.font = UIFont(name: "Lato-Regular", size: rw(22))
        date.textAlignment = .left
        date.text = Utility().getCleanDate(date: historyToPass.date)
        bottomView.addSubview(date)
        
        let location = UILabel()
        location.frame = CGRect(x: rw(20), y: rh(51), width: rw(172), height: rh(14))
        location.textColor = Utility().hexStringToUIColor(hex: "#D6D6D6")
        location.font = UIFont(name: "Lato-Regular", size: rw(15))
        location.textAlignment = .left
        location.text = "\(historyToPass.city), \(historyToPass.country)"
        bottomView.addSubview(location)
        
        let buttonFacture = UIButton()
        buttonFacture.frame = CGRect(x: rw(20), y: rh(75), width: rw(108), height: rh(25))
        buttonFacture.setTitle("Voir la facture >", for: .normal)
        buttonFacture.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonFacture.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(15))
        //buttonFacture.addTarget(self, action: #selector(seeBill), for: .touchUpInside)
        //bottomView.addSubview(buttonFacture)
        
        let totalPrice = UILabel()
        totalPrice.frame = CGRect(x: rw(192), y: rh(16), width: rw(145), height: rh(32))
        totalPrice.textColor = Utility().hexStringToUIColor(hex: "#6CA642")
        totalPrice.font = UIFont(name: "Lato-Regular", size: rw(26))
        totalPrice.textAlignment = .right
        totalPrice.text = "$\(historyToPass.amount.floatValue.twoDecimal)"
        bottomView.addSubview(totalPrice)
        
        let priceAndTaxe = UILabel()
        priceAndTaxe.frame = CGRect(x: rw(192), y: rh(50), width: rw(145), height: rh(10))
        priceAndTaxe.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
        priceAndTaxe.font = UIFont(name: "Lato-Light", size: rw(12))
        priceAndTaxe.textAlignment = .right
        priceAndTaxe.text = "$\(Utility().getTPS(price: historyToPass.amount.floatValue).twoDecimal) + $\(Utility().getTVQ(price: historyToPass.amount.floatValue).twoDecimal)"
        priceAndTaxe.sizeToFit()
        bottomView.addSubview(priceAndTaxe)
        
        
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
    
    func verifyIfSavedAmount()->Bool{
        return priceAllItems > historyToPass.amount.floatValue
    }
    
    func addLBLSaved(){
        if(verifyIfSavedAmount()){
            let LBL_Saved = UILabel()
            LBL_Saved.frame = CGRect(x: rw(273), y: rh(82), width: rw(69), height: rh(10))
            LBL_Saved.textColor = Utility().hexStringToUIColor(hex: "#6CA642")
            LBL_Saved.font = UIFont(name: "Lato-Regular", size: rw(12))
            LBL_Saved.textAlignment = .right
            let totalSaved:Float = priceAllItems - historyToPass.amount.floatValue
            LBL_Saved.text = "- \(totalSaved.twoDecimal) $"
            LBL_Saved.sizeToFit()
            bottomView.addSubview(LBL_Saved)
        }
    }
    


}







