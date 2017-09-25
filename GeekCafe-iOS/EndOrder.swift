//
//  EndOrder.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-25.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class EndOrder: UIViewController {

    let backgroundImage = UIImageView()
    let scrollView = UIScrollView()
    var arrayItem = [Item]()
    let bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Commande"
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        fillFakeInfosArray()
        setUpScrollView()
        fillScrollView()
        setBottomView()
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ((view.frame.height) - rh(75)))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var newY:CGFloat = rh(5)
        if(arrayItem.count > 0){
            for x in arrayItem{
                
                let containerView = UIView()
                containerView.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: 72)
                containerView.backgroundColor = UIColor.clear
                scrollView.addSubview(containerView)
                
                let imageItem = UIImageView()
                imageItem.frame = CGRect(x: rw(15), y: rh(6), width: rw(60), height: rw(60))
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
                newY += (72 + rh(10))
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func setBottomView(){
        
        bottomView.frame = CGRect(x: 0, y: rh(538), width: view.frame.width, height: rh(75))
        bottomView.backgroundColor = UIColor.white
        bottomView.makeShadow(x: 0, y: 2, blur: 4, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.40, spread: 5)
        view.addSubview(bottomView)
        
        let closeButton = UIButton()
        closeButton.createCreateButton(title: "Ajouter un item", frame: CGRect(x: rw(21), y: rh(12), width: rw(165), height: rh(40)), fontSize: rw(20), containerView: bottomView)
        closeButton.addTarget(self, action: #selector(addMore), for: .touchUpInside)
        
        let payButton = UIButton()
        payButton.frame = CGRect(x: rw(254), y: rh(11), width: rw(110), height: rh(40))
        payButton.setTitle("Payer", for: .normal)
        payButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        payButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: rw(20))
        payButton.addTarget(self, action: #selector(animatePayView), for: .touchUpInside)
        bottomView.addSubview(payButton)
        
    }
    
    func fillFakeInfosArray(){
        
        arrayItem.append(Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Choco", price: "3.75"))
        arrayItem.append(Item(image: UIImage(named:"item3")!, type: "Drink", flavour: "Caramel", price: "7.50"))
        arrayItem.append(Item(image:UIImage(named:"item1")!, type: "Drink", flavour: "Vanille", price: "4.00"))
        arrayItem.append(Item(image: UIImage(named:"item3")!, type: "Drink", flavour: "Choco", price: "3.75"))
        arrayItem.append(Item(image: UIImage(named:"item2")!, type: "Drink", flavour: "Choco", price: "3.75"))
        arrayItem.append(Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Choco", price: "3.75"))
    }
    
    func addMore(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func animatePayView(){
        
        removeAllFromBottomView()
        self.buildSecondeBottomView()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.bottomView.frame.size.height = self.rh(240.5)
            self.bottomView.frame.origin.y = self.rh(426)
        }, completion:  { _ in
            self.scrollView.frame.size.height = ((self.view.frame.height) - self.bottomView.frame.height)
        })
    }
    
    func removeAllFromBottomView(){
        for x in bottomView.subviews{
            x.removeFromSuperview()
        }
    }
    
    func buildSecondeBottomView(){
        Utility().createHR(x: rw(14), y: 0, width: rw(361), view: bottomView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        Utility().createHR(x: rw(14), y: rh(53), width: rw(361), view: bottomView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        Utility().createHR(x: rw(14), y: rh(141), width: rw(361), view: bottomView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        Utility().createVerticalHR(x: rw(265), y: rh(6.5), height: rh(41), view: bottomView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        
        let LBL_CartePaiement = UILabel()
        LBL_CartePaiement.createLabel(frame: CGRect(x:rw(14),y:rh(10.5),width:rw(76),height:rh(32)), textColor: Utility().hexStringToUIColor(hex: "#ABABAD"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "CARTE DE PAIEMENT".uppercased())
        LBL_CartePaiement.numberOfLines = 2
        LBL_CartePaiement.lineBreakMode = .byTruncatingHead
        bottomView.addSubview(LBL_CartePaiement)
        
        let LBL_Provider = UILabel()
        LBL_Provider.createLabel(frame: CGRect(x:rw(99),y:rh(8.5),width:rw(160),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "American Express")
        bottomView.addSubview(LBL_Provider)
        
        let LBL_CardNumber = UILabel()
        LBL_CardNumber.createLabel(frame: CGRect(x:rw(99),y:LBL_Provider.frame.maxY,width:rw(160),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "(•••• 5449)")
        bottomView.addSubview(LBL_CardNumber)
        
        let tapAddPromo = UITapGestureRecognizer(target: self, action: #selector(toEnterPromoCode(sender:)))
        
        let LBL_AddPromo = UILabel()
        LBL_AddPromo.createLabel(frame: CGRect(x:rw(285),y:rh(10.5),width:rw(76),height:rh(32)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: "APPLIQUEZ PROMOTION".uppercased())
        LBL_AddPromo.numberOfLines = 2
        LBL_AddPromo.lineBreakMode = .byTruncatingHead
        LBL_AddPromo.addGestureRecognizer(tapAddPromo)
        bottomView.addSubview(LBL_AddPromo)
        
        //Design labels
        let dSubTotal = UILabel()
        dSubTotal.createLabel(frame: CGRect(x:rw(99),y:rh(66.5),width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414").withAlphaComponent(0.4), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Total")
        bottomView.addSubview(dSubTotal)
        
        let dTaxes = UILabel()
        dTaxes.createLabel(frame: CGRect(x:rw(99),y:dSubTotal.frame.maxY,width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414").withAlphaComponent(0.4), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Sales taxes")
        bottomView.addSubview(dTaxes)
        
        let dTotal = UILabel()
        dTotal.createLabel(frame: CGRect(x:rw(99),y:rh(111.5),width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Payment")
        bottomView.addSubview(dTotal)
        
        let SubTotal = UILabel()
        SubTotal.createLabel(frame: CGRect(x:rw(264),y:rh(66.5),width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .right, text: "$2.99")
        bottomView.addSubview(SubTotal)
        
        let Taxes = UILabel()
        Taxes.createLabel(frame: CGRect(x:rw(264),y:SubTotal.frame.maxY,width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .right, text: "$0.99")
        bottomView.addSubview(Taxes)
        
        let Total = UILabel()
        Total.createLabel(frame: CGRect(x:rw(264),y:rh(110),width:rw(100),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(17), textAignment: .right, text: "$3.78")
        bottomView.addSubview(Total)
        
        
        let BTN_Pay = UIButton()
        BTN_Pay.createCreateButton(title: "Payer", frame: CGRect(x:rw(88),y:rh(166.5),width:rw(202),height:rh(50)), fontSize: rw(20), containerView: bottomView)
        
    }
    
    func toEnterPromoCode(sender:UITapGestureRecognizer){
        print("Promo applied")
    }
}
