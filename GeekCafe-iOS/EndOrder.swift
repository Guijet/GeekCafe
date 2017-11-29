//
//  EndOrder.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-25.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct TotalPrice{
    init(error:Bool,subtotal:NSNumber,total:NSNumber,priceSaved:NSNumber,message:String = "",taxes:NSNumber){
        self.error = error
        self.subtotal = subtotal
        self.total = total
        self.taxes = taxes
        self.priceSaved = priceSaved
        self.message = message
    }
    var error:Bool
    var subtotal:NSNumber
    var total:NSNumber
    var priceSaved:NSNumber
    var taxes:NSNumber
    var message:String
}

class EndOrder: UIViewController,UITextFieldDelegate{

    fileprivate let backgroundImage = UIImageView()
    fileprivate let scrollView  = UIScrollView()
    fileprivate var arrayItems = [itemOrder]()
    fileprivate let bottomView = UIView()
    let loading = loadingIndicator()
    
    
    //BOOL IF USER HAS ENOUGH CREDIT
    fileprivate var isCredit:Bool = false
     
    //Promo view elements
    fileprivate let promoContainer = UIView()
    fileprivate let promoTitle = UILabel()
    fileprivate let TB_Promo = UITextField()
    fileprivate let TB_Points = UITextField()
    fileprivate let HR = UIView()
    fileprivate let X_Button = UIButton()
    fileprivate let BTN_Apply = UIButton()
    fileprivate let BTN_ApplyPoints = UIButton()
    fileprivate var arrAlphaAnimation:[UIView] = [UIView]()
    fileprivate var isPointsUsed:Bool = false
    fileprivate var isPromoUsed:Bool = false
    fileprivate var promoCode:String = ""
    fileprivate var numberOfPointsUsed:Int = 0
    fileprivate var checkPrices:TotalPrice!


    let SubTotal = UILabel()
    let Taxes = UILabel()
    let Total = UILabel()
    let SavedTotal = UILabel()
    
    //Keyboards
    fileprivate var isKeyboardActive:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Commande"
        self.navigationItem.setHidesBackButton(true, animated:false)
        self.loading.buildViewAndStartAnimate(view: self.view)
        DispatchQueue.global(qos:.background).async {
            self.checkPrices = self.verifyPrice()
            DispatchQueue.main.async {
                self.backgroundImage.setUpBackgroundImage(containerView: self.view)
                self.setUpScrollView()
                self.fillScrollView()
                self.setBottomView()
                self.loading.stopAnimatingAndRemove(view: self.view)
            }
        }
    }
    //
    //
    //SET UPS FOR SCROLLVIEW WITH ITEMS FROM ORDER
    //
    //
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(607))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var newY:CGFloat = rh(5)
        if(Global.global.itemsOrder.count > 0){
            for x in Global.global.itemsOrder{
                
                let containerView = UIView()
                containerView.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: 72)
                containerView.backgroundColor = UIColor.clear
                scrollView.addSubview(containerView)
                
                if(x.arrayImage.count > 0){
                    for y in x.arrayImage{
                        let imageItem = UIImageView()
                        imageItem.frame = CGRect(x: rw(15), y: rh(6), width: rw(60), height: rw(60))
                        imageItem.contentMode = .scaleAspectFit
                        imageItem.image = y
                        containerView.addSubview(imageItem)
                    }
                }
                else{
                    let imageItem = UIImageView()
                    imageItem.frame = CGRect(x: rw(15), y: rh(6), width: rw(60), height: rw(60))
                    imageItem.contentMode = .scaleAspectFit
                    imageItem.getOptimizeImageAsync(url: x.image)
                    containerView.addSubview(imageItem)
                }
                
                
                
                let price = UILabel()
                price.frame = CGRect(x: rw(260), y: (containerView.frame.height/2) - rh(10), width: rw(100), height: rh(20))
                price.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                price.font = UIFont(name: "Lato-Regular", size: rw(18))
                price.textAlignment = .right
                price.text = "\(x.price.floatValue.twoDecimal) $"
                containerView.addSubview(price)
                
                let flavour = UILabel()
                flavour.frame = CGRect(x: rw(85), y: ((containerView.frame.height/2) - rh(10)), width: price.frame.minX - rh(85), height: rh(20))
                flavour.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                flavour.font = UIFont(name: "Lato-Regular", size: rw(15))
                flavour.textAlignment = .left
                flavour.text = x.name
                containerView.addSubview(flavour)
                
                let type = UILabel()
                type.frame = CGRect(x: rw(85), y: ((containerView.frame.height/2)+rh(3)), width: price.frame.minX - rh(85), height: rh(20))
                type.textColor = Utility().hexStringToUIColor(hex: "#D6D6D6")
                type.font = UIFont(name: "Lato-Regular", size: rw(13))
                type.textAlignment = .left
                type.text = x.type
                //containerView.addSubview(type)
                
                newY += (72 + rh(10))
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    //
    //
    //BUILD ON CREATE OF THE VIEW
    //
    //
    func setBottomView(){
        
        bottomView.frame = CGRect(x: 0, y: rh(602), width: view.frame.width, height: rh(75))
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
    
    //
    //
    //ANIMATIONS FUNCTION
    //IN: FUNCTION TO BUILD VIEWS, NEW HEIGHT OF THE VIEW
    //
    //
    func resetBottomView(function:@escaping ()->(),height:CGFloat){
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.bottomView.frame.origin.y = self.view.frame.height
        }, completion: {  _ in
            self.removeAllFromBottomView()
            function()
            self.bottomView.frame.size.height = height
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                self.bottomView.frame.origin.y = self.view.frame.height - height
                self.scrollView.frame.size.height = self.view.frame.height - self.bottomView.frame.height
            }, completion: {  _ in
                self.view.isUserInteractionEnabled = true
            })
        })
    }
    
    

    func resetBuildBaseBottomView(){
        
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
    
    func buildFirstBottomView(){
        
        let topInnerView = UIView()
        topInnerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(45))
        topInnerView.backgroundColor = Utility().hexStringToUIColor(hex: "#F7F7F7")
        bottomView.addSubview(topInnerView)
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: rw(300), y: rh(5), width: rw(60), height: rh(35))
        closeButton.setTitle("Fermer", for: .normal)
        closeButton.setTitleColor(Utility().hexStringToUIColor(hex: "#000000"), for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(15))
        closeButton.addTarget(self, action: #selector(setBaseBottomView), for: .touchUpInside)
        topInnerView.addSubview(closeButton)
        
        let bottomInnerView = UIView()
        bottomInnerView.frame = CGRect(x: 0, y: topInnerView.frame.maxY, width: view.frame.width, height: rh(136))
        bottomInnerView.backgroundColor = UIColor.white
        bottomView.addSubview(bottomInnerView)
        
        Utility().createHR(x: 0, y: 0, width: view.frame.width, view: bottomInnerView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        
        

        let labelComptoir = UILabel()
        labelComptoir.isUserInteractionEnabled = true
        labelComptoir.createLabel(frame: CGRect(x:rw(205),y:rh(101),width:rw(120),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(15), textAignment: .center, text: "Payer au comptoir")
        
        
        let buttonImageInStore = UIButton()
        buttonImageInStore.frame = CGRect(x: rw(245), y: rh(25), width: rw(64), height: rw(64))
        buttonImageInStore.setImage(UIImage(named:"pay_in_store"), for: .normal)
        buttonImageInStore.addTarget(self, action: #selector(payInStore), for: .touchUpInside)
        
        
        let tapPayInApp = UITapGestureRecognizer(target: self, action: #selector(payInApp))
        
        let labelPayInApp = UILabel()
        labelPayInApp.isUserInteractionEnabled = true
        labelPayInApp.addGestureRecognizer(tapPayInApp)
        labelPayInApp.createLabel(frame: CGRect(x:rw(29.5),y:rh(101),width:rw(120),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(15), textAignment: .center, text: "Payer dans l'app")
        
        
        let buttonImageInApp = UIButton()
        buttonImageInApp.frame = CGRect(x: rw(57), y: rh(16), width: rw(74), height: rw(74))
        buttonImageInApp.setImage(UIImage(named:"pay_in_app"), for: .normal)
        buttonImageInApp.addTarget(self, action: #selector(payInApp), for: .touchUpInside)
        
        if(Global.global.userInfo.cards.count > 0){
            bottomInnerView.addSubview(labelComptoir)
            bottomInnerView.addSubview(buttonImageInStore)
            bottomInnerView.addSubview(labelPayInApp)
            bottomInnerView.addSubview(buttonImageInApp)
        }
        else{
            labelComptoir.frame.origin.x = (view.frame.midX - (labelComptoir.frame.width/2))
            buttonImageInStore.frame.origin.x = (view.frame.midX - (buttonImageInStore.frame.width/2))
            bottomInnerView.addSubview(labelComptoir)
            bottomInnerView.addSubview(buttonImageInStore)
        }
        
        
    }
    
    func buildSecondeBottomView(){
        
        let topInnerView = UIView()
        topInnerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(45))
        topInnerView.backgroundColor = Utility().hexStringToUIColor(hex: "#F7F7F7")
        bottomView.addSubview(topInnerView)
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: rw(300), y: rh(5), width: rw(60), height: rh(35))
        closeButton.setTitle("Fermer", for: .normal)
        closeButton.setTitleColor(Utility().hexStringToUIColor(hex: "#000000"), for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(15))
        closeButton.addTarget(self, action: #selector(setBaseBottomView), for: .touchUpInside)
        topInnerView.addSubview(closeButton)
        
        let containerMainView = UIView()
        containerMainView.frame = CGRect(x: 0, y: topInnerView.frame.maxY, width: view.frame.width, height: rh(240.5))
        bottomView.addSubview(containerMainView)
        
        Utility().createHR(x: 0, y: 0, width: view.frame.width, view: containerMainView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        Utility().createHR(x: rw(14), y: rh(53), width: rw(361), view: containerMainView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        Utility().createHR(x: rw(14), y: rh(141), width: rw(361), view: containerMainView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        
        
        let LBL_CartePaiement = UILabel()
        LBL_CartePaiement.createLabel(frame: CGRect(x:rw(14),y:rh(10.5),width:rw(76),height:rh(32)), textColor: Utility().hexStringToUIColor(hex: "#ABABAD"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "CARTE DE PAIEMENT".uppercased())
        LBL_CartePaiement.numberOfLines = 2
        LBL_CartePaiement.lineBreakMode = .byTruncatingHead
        containerMainView.addSubview(LBL_CartePaiement)

        if(Global.global.userInfo.cards.count > 0){

            let LBL_Provider = UILabel()
            LBL_Provider.createLabel(frame: CGRect(x:rw(99),y:rh(8.5),width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "\(Global.global.userInfo.cards[0].brand)")
            containerMainView.addSubview(LBL_Provider)
        
            let LBL_CardNumber = UILabel()
            LBL_CardNumber.createLabel(frame: CGRect(x:rw(99),y:LBL_Provider.frame.maxY,width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .left, text: "(•••• \(Global.global.userInfo.cards[0].last4))")
            containerMainView.addSubview(LBL_CardNumber)
        }
        else{
            //PAS DE CARTE
        }

        
        let tapAddPromo = UITapGestureRecognizer(target: self, action: #selector(toEnterPromoCode))
        
        let LBL_AddPromo = UILabel()
        LBL_AddPromo.isUserInteractionEnabled = true
        LBL_AddPromo.createLabel(frame: CGRect(x:rw(297),y:rh(10.5),width:rw(76),height:rh(32)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(10), textAignment: .center, text: "APPLIQUEZ PROMOTION".uppercased())
        LBL_AddPromo.numberOfLines = 2
        LBL_AddPromo.lineBreakMode = .byTruncatingHead
        LBL_AddPromo.addGestureRecognizer(tapAddPromo)
        containerMainView.addSubview(LBL_AddPromo)
        
        Utility().createVerticalHR(x: rw(297), y: rh(6.5), height: rh(41), view: containerMainView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        
        
        
        if(Global.global.userInfo.points > 0){
            let tapPoints = UITapGestureRecognizer(target: self, action: #selector(usePoints))
            let LBL_AddPoints = UILabel()
            LBL_AddPoints.isUserInteractionEnabled = true
            LBL_AddPoints.createLabel(frame: CGRect(x:rw(220),y:rh(10.5),width:rw(76),height:rh(32)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(10), textAignment: .center, text: "UTILISER DES POINTS".uppercased())
            LBL_AddPoints.numberOfLines = 2
            LBL_AddPoints.lineBreakMode = .byTruncatingHead
            LBL_AddPoints.addGestureRecognizer(tapPoints)
            containerMainView.addSubview(LBL_AddPoints)
        }
        
        
        //Design labels
        let dSubTotal = UILabel()
        dSubTotal.createLabel(frame: CGRect(x:rw(99),y:rh(55),width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414").withAlphaComponent(0.4), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Total")
        containerMainView.addSubview(dSubTotal)
        
        let dTaxes = UILabel()
        dTaxes.createLabel(frame: CGRect(x:rw(99),y:dSubTotal.frame.maxY,width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414").withAlphaComponent(0.4), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Sales taxes")
        containerMainView.addSubview(dTaxes)
        
        let dAmountSave = UILabel()
        dAmountSave.createLabel(frame: CGRect(x:rw(99),y:dTaxes.frame.maxY,width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414").withAlphaComponent(0.4), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Promotions")
        containerMainView.addSubview(dAmountSave)
        
        let dTotal = UILabel()
        dTotal.createLabel(frame: CGRect(x:rw(99),y:rh(116.5),width:rw(56),height:rh(17)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .left, text: "Payment")
        containerMainView.addSubview(dTotal)
        
        
        SubTotal.createLabel(frame: CGRect(x:rw(264),y:rh(55),width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .right, text:"\(checkPrices.subtotal.floatValue.twoDecimal) $")
        containerMainView.addSubview(SubTotal)
        
        
        Taxes.createLabel(frame: CGRect(x:rw(264),y:SubTotal.frame.maxY,width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .right, text: "\(checkPrices.taxes.floatValue.twoDecimal) $")
        containerMainView.addSubview(Taxes)
        
        SavedTotal.createLabel(frame: CGRect(x:rw(264),y:Taxes.frame.maxY,width:rw(100),height:rh(16)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(11), textAignment: .right, text: "- \(checkPrices.priceSaved.floatValue.twoDecimal) $")
        containerMainView.addSubview(SavedTotal)
        
        Total.createLabel(frame: CGRect(x:rw(264),y:rh(115),width:rw(100),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#141414"), fontName: "Lato-Regular", fontSize: rw(17), textAignment: .right, text: "\(checkPrices.total.floatValue.twoDecimal) $")
        containerMainView.addSubview(Total)
        
        let BTN_Pay = UIButton()
        BTN_Pay.createCreateButton(title: "Payer", frame: CGRect(x:rw(88),y:rh(166.5),width:rw(202),height:rh(50)), fontSize: rw(20), containerView: containerMainView)
        BTN_Pay.addTarget(self, action: #selector(payPressed(sender:)), for: .touchUpInside)
        
    }
    
    
    func buildThirdBottomView(){
       
        
        let topInnerView = UIView()
        topInnerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(45))
        topInnerView.backgroundColor = Utility().hexStringToUIColor(hex: "#F7F7F7")
        bottomView.addSubview(topInnerView)
        
        let labelTotalInCash = UILabel()
        labelTotalInCash.createLabel(frame: CGRect(x:rw(20),y:topInnerView.frame.height/2 - rh(10),width:view.frame.width/2,height:rh(20)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(14), textAignment: .left, text: "10,00$")
        labelTotalInCash.sizeToFit()
        topInnerView.addSubview(labelTotalInCash)
        
        let labelCreditD = UILabel()
        labelCreditD.createLabel(frame: CGRect(x:labelTotalInCash.frame.maxX + rw(2),y:topInnerView.frame.height/2 - rh(10),width:rw(100),height:rh(20)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Light", fontSize: rw(12), textAignment: .left, text: "crédit disponible")
        topInnerView.addSubview(labelCreditD)
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: rw(300), y: rh(5), width: rw(60), height: rh(35))
        closeButton.setTitle("Fermer", for: .normal)
        closeButton.setTitleColor(Utility().hexStringToUIColor(hex: "#000000"), for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(15))
        closeButton.addTarget(self, action: #selector(setBaseBottomView), for: .touchUpInside)
        topInnerView.addSubview(closeButton)
        
        let bottomInnerView = UIView()
        bottomInnerView.frame = CGRect(x: 0, y: topInnerView.frame.maxY, width: view.frame.width, height: rh(159))
        bottomView.addSubview(bottomInnerView)
        
        Utility().createHR(x: 0, y: 0, width: view.frame.width, view: bottomInnerView, color: Utility().hexStringToUIColor(hex: "#DEDEDE"))
        
        let labelLine1D = UILabel()
        labelLine1D.createLabel(frame: CGRect(x:0,y:rh(16),width:view.frame.width,height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#9B9B9B"), fontName: "Lato-Light", fontSize: rw(20), textAignment: .center, text: "Vous avez assez de crédit pour")
        bottomInnerView.addSubview(labelLine1D)
        
        let labelLine2D = UILabel()
        labelLine2D.createLabel(frame: CGRect(x:0,y:labelLine1D.frame.maxY,width:view.frame.width,height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#9B9B9B"), fontName: "Lato-Light", fontSize: rw(20), textAignment: .center, text: "complété votre achat")
        bottomInnerView.addSubview(labelLine2D)
        
        let BTN_PayWithCredit = UIButton()
        BTN_PayWithCredit.createCreateButton(title: "Payer avec mes crédits", frame: CGRect(x:rw(25),y:rh(89),width:rw(219),height:rh(50)), fontSize: rw(20), containerView: bottomInnerView)
        //BTN_PayWithCredit.addTarget(self, action: #selector(payWithPoints), for: .touchUpInside)
        
        let BTN_NonMerci = UIButton()
        BTN_NonMerci.frame = CGRect(x: rw(263), y: rh(94), width: rw(80), height: rh(40))
        BTN_NonMerci.setTitle("Non Merci", for: .normal)
        BTN_NonMerci.setTitleColor(Utility().hexStringToUIColor(hex: "#9B9B9B"), for: .normal)
        BTN_NonMerci.titleLabel?.font = UIFont(name: "Lato-Light", size: rw(13))
        BTN_NonMerci.addTarget(self, action: #selector(noCreditsChoose), for: .touchUpInside)
        bottomInnerView.addSubview(BTN_NonMerci)
    }
    
    
    //
    //
    //BOTTOM VIEWS ACTIONS
    //
    //
    func removeAllFromBottomView(){
        for x in bottomView.subviews{
            x.removeFromSuperview()
        }
    }
    
    @objc func animatePayView(){
        if(isCredit){
            resetBottomView(function: buildThirdBottomView, height: rh(204))
        }
        else{
            resetBottomView(function: buildFirstBottomView, height: rh(191))
        }
    }
    
    @objc func noCreditsChoose(){
        resetBottomView(function: buildFirstBottomView, height: rh(191))
    }
    
    @objc func setBaseBottomView(){
        resetBottomView(function: self.resetBuildBaseBottomView, height: rh(64))
    }
    
    @objc func payInApp(){
        resetBottomView(function: buildSecondeBottomView, height: rh(285.5))
    }
    
    @objc func payInStore(){
        
        if(APIRequestCommande().order(arrayItems: Global.global.itemsOrder, card_pay: false, branch_id: 6, counter_id: 1,points:numberOfPointsUsed)){
            performSegue(withIdentifier: "toConfirmation", sender: nil)
        }
        else{
            performSegue(withIdentifier: "toFailedOrder", sender: nil)
        }
    }
    

    
    
    
    //
    //
    //PROMO CODE VIEWS HANDLING
    //
    //
    func buildPromoView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        arrAlphaAnimation = [promoContainer,promoTitle,TB_Promo,HR,X_Button,BTN_Apply]
        
        promoContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 64)
        promoContainer.addGestureRecognizer(tapGesture)
        promoContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        promoContainer.alpha = 0
    
        
        
        promoTitle.createLabel(frame: CGRect(x:0,y:rh(196),width:view.frame.width,height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Light", fontSize: rw(25), textAignment: .center, text: "Inscrire votre code promo")
        promoTitle.alpha = 0
        promoContainer.addSubview(promoTitle)
        
        TB_Promo.delegate = self
        TB_Promo.autocorrectionType = .no
        TB_Promo.frame = CGRect(x: rw(25), y: rh(280), width: rw(315), height: rh(48))
        TB_Promo.placeholder = "Entrez ici"
        TB_Promo.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Hairline", fontSize: rw(40.0))
        TB_Promo.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        TB_Promo.font = UIFont(name: "Lato-Hairline", size: rw(48))
        TB_Promo.textAlignment = .left
        TB_Promo.alpha = 0
        promoContainer.addSubview(TB_Promo)
        
        HR.frame = CGRect(x: rw(25), y: TB_Promo.frame.maxY + rh(6), width: rw(315), height: 1)
        HR.backgroundColor = Utility().hexStringToUIColor(hex: "#979797")
        HR.alpha = 0
        promoContainer.addSubview(HR)
        
        X_Button.frame = CGRect(x: rw(310), y: rh(25), width: rw(40), height: rw(40))
        X_Button.setImage(UIImage(named:"letter-x"), for: .normal)
        X_Button.addTarget(self, action: #selector(xPressed), for: .touchUpInside)
        X_Button.layer.zPosition = 1
        X_Button.imageEdgeInsets = UIEdgeInsets(top: rw(6.5), left: rw(6.5), bottom: rw(6.5), right: rw(6.5))
        X_Button.alpha = 0
        promoContainer.addSubview(X_Button)
        
        //y to 592
        BTN_Apply.createCreateButton(title: "Appliquer", frame: CGRect(x:rw(88),y:rh(592) + 64,width:rw(202),height:rh(50)), fontSize: rw(20), containerView: promoContainer)
        BTN_Apply.addTarget(self, action: #selector(usePromoCode), for: .touchUpInside)
        
        UIApplication.shared.keyWindow?.addSubview(promoContainer)
    }
    
    //
    //
    //CLOSING VIEW FOR PROMOTION OR POINTS
    //
    //
    @objc func xPressed(){
        self.endEditing()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            for x in self.arrAlphaAnimation{
                x.alpha = 0
            }
        }, completion: { _ in
            self.promoContainer.removeFromSuperview()
            self.arrAlphaAnimation.removeAll()
            self.view.isUserInteractionEnabled = true
        })
    }
    

    //
    //
    //ANIMATES PROMOVIEW
    //
    //
    @objc func toEnterPromoCode(){
        buildPromoView()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            for x in self.arrAlphaAnimation{
                x.alpha = 1
            }
        }, completion:{ _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    //
    //
    //TEXTFIEDLS DELEGATE
    //
    //
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(!isKeyboardActive){
            //moveUp()
            isKeyboardActive = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if(isKeyboardActive){
            //moveDown()
            isKeyboardActive = false
        }
    }
    
    func moveUp(){
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.BTN_Apply.center.y -= self.rh(270)
        }, completion:{ _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func moveDown(){
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.BTN_Apply.center.y += self.rh(270)
        }, completion:{ _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func endEditing(){
        self.promoContainer.endEditing(true)
    }





    @objc func usePoints(){
        buildPointsView()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            for x in self.arrAlphaAnimation{
                x.alpha = 1
            }
        }, completion:{ _ in
            self.view.isUserInteractionEnabled = true
        })
    }


    //
    //
    //BUILD VIEW FOR ADD POINTS
    //
    //
    func buildPointsView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        arrAlphaAnimation = [promoContainer,promoTitle,TB_Points,HR,X_Button,BTN_ApplyPoints]
        
        promoContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 64)
        promoContainer.addGestureRecognizer(tapGesture)
        promoContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        promoContainer.alpha = 0
        
        
        promoTitle.createLabel(frame: CGRect(x:0,y:rh(181),width:view.frame.width,height:rh(70)), textColor: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Light", fontSize: rw(23), textAignment: .center, text: "Vous avez présentement \(Global.global.userInfo.points) points. \nCombien voulez vous en utiliser?")
        promoTitle.numberOfLines = 2
        promoTitle.lineBreakMode = .byTruncatingTail
        promoTitle.alpha = 0
        promoContainer.addSubview(promoTitle)
        
        TB_Points.delegate = self
        TB_Points.autocorrectionType = .no
        TB_Points.keyboardType = .numberPad
        TB_Points.frame = CGRect(x: rw(25), y: rh(280), width: rw(315), height: rh(48))
        TB_Points.placeholder = "Entrez ici"
        TB_Points.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Hairline", fontSize: rw(40.0))
        TB_Points.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        TB_Points.font = UIFont(name: "Lato-Hairline", size: rw(48))
        TB_Points.textAlignment = .left
        TB_Points.alpha = 0
        promoContainer.addSubview(TB_Points)
        
        HR.frame = CGRect(x: rw(25), y: TB_Points.frame.maxY + rh(6), width: rw(315), height: 1)
        HR.backgroundColor = Utility().hexStringToUIColor(hex: "#979797")
        HR.alpha = 0
        promoContainer.addSubview(HR)
        
        X_Button.frame = CGRect(x: rw(310), y: rh(25), width: rw(40), height: rw(40))
        X_Button.setImage(UIImage(named:"letter-x"), for: .normal)
        X_Button.addTarget(self, action: #selector(xPressed), for: .touchUpInside)
        X_Button.layer.zPosition = 1
        X_Button.imageEdgeInsets = UIEdgeInsets(top: rw(6.5), left: rw(6.5), bottom: rw(6.5), right: rw(6.5))
        X_Button.alpha = 0
        promoContainer.addSubview(X_Button)
        
        //y to 592
        BTN_ApplyPoints.createCreateButton(title: "Appliquer", frame: CGRect(x:rw(88),y:rh(330) + 64,width:rw(202),height:rh(50)), fontSize: rw(20), containerView: promoContainer)
        BTN_ApplyPoints.addTarget(self, action: #selector(pointsAdded), for: .touchUpInside)
        
        UIApplication.shared.keyWindow?.addSubview(promoContainer)
    }

    //TODO:ADD CHECK PRICE
    @objc func pointsAdded(){
        xPressed()
        if(TB_Points.text != ""){
            if(Int(TB_Points.text!)! <= Global.global.userInfo.points){
                numberOfPointsUsed = Int(TB_Points.text!)!
                if(promoCode == ""){
                    self.checkPrices = verifyPrice()
                }
                else{
                    self.checkPrices = verifyPrice(promoCode:promoCode)
                }
                if(!self.checkPrices.error){
                    isPointsUsed = true
                    updatePrice()
                    Utility().alert(message: "Points ajouter avec succès à votre commande!", title: "Message", control: self)
                }
                else{
                    Utility().alert(message: checkPrices.message, title: "Error", control: self)
                }
                TB_Points.text = ""
            }
            else{
                Utility().alert(message: "Vous n'avez pas assez de points.", title: "Message", control: self)
            }
        }
        else{
            Utility().alert(message: "Vous devez entrer une valeur de points", title: "Message", control: self)
        }

        
    }
    
    @objc func usePromoCode(){
        xPressed()
        if(TB_Promo.text != ""){
            promoCode = TB_Promo.text!
            self.checkPrices = verifyPrice(promoCode: TB_Promo.text!)
            if(!self.checkPrices.error){
                isPromoUsed = true
                updatePrice()
                Utility().alert(message: "Rabais appliquer avec succès sur votre commande", title: "Message", control: self)
            }
            else{
                Utility().alert(message: self.checkPrices.message, title: "Message", control: self)
            }
            TB_Promo.text = ""
        }
        else{
            Utility().alert(message: "Vous devez entrer un code de promotions", title: "Error", control: self)
        }
    }
    
    func updatePrice(){
        SubTotal.text = "\(checkPrices.subtotal.floatValue.twoDecimal) $"
        Taxes.text = "\(checkPrices.taxes.floatValue.twoDecimal) $"
        SavedTotal.text = "- \(checkPrices.priceSaved.floatValue.twoDecimal) $"
        Total.text = "\(checkPrices.total.floatValue.twoDecimal) $"
    }
        
    func fillArrayPrices()->[NSNumber]{
        var arrayPrices:[NSNumber] = [NSNumber]()
        
        for x in Global.global.itemsOrder{
            arrayPrices.append(x.price)
        }
        
        return arrayPrices
    }
    

    @objc func payPressed(sender:UIButton){
        self.loading.buildViewAndStartAnimate(view:self.view)
        DispatchQueue.global().async {
            if(Global.global.userInfo.cards.count > 0){
                if(!self.isPromoUsed){
                    if(APIRequestCommande().order(arrayItems: Global.global.itemsOrder, card_pay: true, branch_id: 6, counter_id: 1, points: self.numberOfPointsUsed)){
                        DispatchQueue.main.async {
                            self.loading.stopAnimatingAndRemove(view: self.view)
                            self.performSegue(withIdentifier: "toConfirmation", sender: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.loading.stopAnimatingAndRemove(view: self.view)
                            self.performSegue(withIdentifier: "toFailedOrder", sender: nil)
                        }
                    }
                }
                else{
                    if(APIRequestCommande().order(arrayItems: Global.global.itemsOrder, card_pay: true, branch_id: 6, counter_id: 1, points: self.numberOfPointsUsed,promoCode:self.promoCode)){
                        DispatchQueue.main.async {
                            self.loading.stopAnimatingAndRemove(view: self.view)
                            self.performSegue(withIdentifier: "toConfirmation", sender: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.loading.stopAnimatingAndRemove(view: self.view)
                            self.performSegue(withIdentifier: "toFailedOrder", sender: nil)
                        }
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.loading.stopAnimatingAndRemove(view: self.view)
                    Utility().alert(message: "You have not payment method set up", title: "Message", control: self)
                }
            }
        }
    }
    func updatPointsFirstViewController(){
        let rootViewController = self.navigationController?.viewControllers.first
        (rootViewController as! CommandeMainPage).menu.updatePointsValue()
    }
    
    @objc func addMore(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    //HERE
    //VERIFY PRICES
    func verifyPrice(promoCode:String = "")->TotalPrice{
        var json:[String:Any]!
        var totalPrice:TotalPrice!
        var error:Bool!
        var errorMessage:String = ""
        var total:NSNumber!
        var subtotal:NSNumber!
        var taxes:NSNumber!
        var priceSaved:NSNumber!
        
        if(promoCode == ""){
            json = APIRequestCommande().checkPriceOrder(arrayItems: Global.global.itemsOrder,  points: numberOfPointsUsed)
        }
        else{
            json = APIRequestCommande().checkPriceOrder(arrayItems: Global.global.itemsOrder,  points: numberOfPointsUsed,promoCode:promoCode)
        }
        
        if let errorS = json["error"] as? String{
            error = true
            errorMessage = errorS
        }
        else{
            error = false
        }
        if let order = json["order"] as? [String:Any]{
            if let reducedAmountN = order["reduced"] as? NSNumber{
                priceSaved = reducedAmountN
            }
            else{
                priceSaved = 0
            }
            if let subtotalN = order["subtotal"] as? NSNumber{
                subtotal = subtotalN
            }
            else{
                subtotal = 0
            }
            if let totalN = order["total"] as? NSNumber{
                total = totalN
            }
            else{
                total = 0
            }
            if let taxesN = order["taxes"] as? NSNumber{
                taxes = taxesN
            }
            else{
                taxes = 0
            }
            totalPrice = TotalPrice(error: error, subtotal: subtotal, total: total, priceSaved: priceSaved, taxes: taxes)
        }
        else{
            totalPrice = TotalPrice(error: error, subtotal: 0, total: 0, priceSaved: 0,message:errorMessage, taxes: taxes)
        }
        return totalPrice
    }
}
