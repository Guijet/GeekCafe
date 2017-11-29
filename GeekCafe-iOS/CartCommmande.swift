//
//  CartCommmande.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class CartCommmande: UIViewController,UIGestureRecognizerDelegate {

    private var rightButtonDelete = UIButton()
    private var isOpenLeft:Bool = false
    private var isOpenRight:Bool = false
    let backgroundImage = UIImageView()
    let scrollView = UIScrollView()
    var arrayItems = [itemOrder]()
    var arrayItem = [Item]()
    var checkPrices:TotalPrice!
    var tagSelectedSwipe = -1
    var lastElementY : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPrices = verifyPrice()
        setNavigationTitle()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setUpScrollView()
        setUpBScrollableButtons()
        fillScrollView()
        setBottomView()
    }
    
    //To make bar all white non translucent and appearing
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Commande"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: ((view.frame.height - 64) - rh(75)))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
    }
    

    // Instantiate the delete button when swipe
    private func setUpBScrollableButtons(){
        rightButtonDelete.backgroundColor = UIColor.clear
        rightButtonDelete.isHidden = true
        rightButtonDelete.setImage(UIImage(named:"removeButton"), for: .normal)
        rightButtonDelete.imageEdgeInsets = UIEdgeInsets(top: 22, left: 20, bottom: 22, right: 20)
        rightButtonDelete.addTarget(self, action: #selector(deleteRow), for: .touchUpInside)
        rightButtonDelete.layer.zPosition = 0
        rightButtonDelete.tag = -1
    }

    func fillScrollView(){
        var newY:CGFloat = rh(5)
        var index = 0
        if(Global.global.itemsOrder.count > 0){
            scrollView.addSubview(rightButtonDelete)
            for x in Global.global.itemsOrder{
                
                let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipe(sender:)))
                leftSwipe.delegate = self
                leftSwipe.direction = .left;
                
            
                let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipe(sender:)))
                rightSwipe.delegate = self
                rightSwipe.direction = .right;
                

                let containerView = UIView()
                containerView.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: 72)
                containerView.backgroundColor = UIColor.clear
                containerView.tag = index
                scrollView.addSubview(containerView)
                containerView.addGestureRecognizer(leftSwipe)
                containerView.addGestureRecognizer(rightSwipe)
                
                let imageItem = UIImageView()
                imageItem.frame = CGRect(x: rw(15), y: rh(6), width: rw(60), height: rw(60))
                imageItem.getOptimizeImageAsync(url: x.image)
                containerView.addSubview(imageItem)
                
                let price = UILabel()
                price.frame = CGRect(x: rw(260), y: (containerView.frame.height/2) - rh(10), width: rw(100), height: rh(20))
                price.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                price.font = UIFont(name: "Lato-Regular", size: rw(18))
                price.textAlignment = .right
                price.text = "$\(x.price.floatValue.twoDecimal)"
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
                type.text = "\(x.name)"
                containerView.addSubview(type)
                newY += (72 + rh(10))
                index += 1
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
        else{
            let labelNoHistory = UILabel()
            labelNoHistory.numberOfLines = 2
            labelNoHistory.createLabel(frame: CGRect(x:0,y:rh(225),width:view.frame.width,height:60), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(16), textAignment: .center, text: "Vous avez présentement \naucun item dans votre commandes.")
            labelNoHistory.numberOfLines = 2
            scrollView.addSubview(labelNoHistory)
        }
    }
    
    func setBottomView(){
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: rh(602), width: view.frame.width, height: rh(75))
        bottomView.backgroundColor = UIColor.white
        bottomView.makeShadow(x: 0, y: 2, blur: 4, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.40, spread: 5)
        view.addSubview(bottomView)
        
        let closeButton = UIButton()
        closeButton.createCreateButton(title: "Payer", frame: CGRect(x: rw(21), y: rh(12), width: rw(129), height: rh(40)), fontSize: rw(20), containerView: bottomView)
        closeButton.addTarget(self, action: #selector(toPay), for: .touchUpInside)
        
        let priceLabel = UILabel()
        priceLabel.createLabel(frame: CGRect(x: view.frame.midX, y: rh(14), width: (view.frame.width/2) - rw(30), height: rh(32)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(26), textAignment: .right, text: "\(checkPrices.subtotal.floatValue.twoDecimal)$")
        bottomView.addSubview(priceLabel)
    }

    //HERE
    //VERIFY PRICES
    func verifyPrice()->TotalPrice{
        var totalPrice:TotalPrice!
        var error:Bool!
        var errorMessage:String = ""
        var total:NSNumber!
        var subtotal:NSNumber!
        var priceSaved:NSNumber!
    
        let json = APIRequestCommande().checkPriceOrder(arrayItems: Global.global.itemsOrder,  points: 0)
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
            
            totalPrice = TotalPrice(error: error, subtotal: subtotal, total: total, priceSaved: priceSaved)
        }
        else{
            totalPrice = TotalPrice(error: error, subtotal: 0, total: 0, priceSaved: 0,message:errorMessage)
        }
        return totalPrice
    }
    
    @objc private func swipe(sender:AnyObject)
    {
        let swipeGesture:UISwipeGestureRecognizer = sender as! UISwipeGestureRecognizer
        if(tagSelectedSwipe != -1 && tagSelectedSwipe != swipeGesture.view!.tag) { return }
        if(swipeGesture.direction == .left)
        {
            if(!isOpenLeft && !isOpenRight){
                moveAllLeft(contentView: swipeGesture.view!)
                isOpenRight = true
            }
            else if(isOpenLeft){
                moveAllLeft(contentView: swipeGesture.view!)
                isOpenRight = false
                isOpenLeft = false
            }
        }
        else if(swipeGesture.direction == .right)
        {
            if(isOpenRight){
                moveAllRight(contentView: swipeGesture.view!)
                isOpenRight = false
                isOpenLeft = false
                
            }
        }
    }

    private func moveAllLeft(contentView : UIView){
        let widthScreen = UIScreen.main.bounds.width
        rightButtonDelete.frame = CGRect(x: widthScreen, y: contentView.frame.minY, width: 70, height:  contentView.frame.height)
        self.rightButtonDelete.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            contentView.center.x -= 70
            
            self.rightButtonDelete.center.x -= 70
        }, completion: nil)
        tagSelectedSwipe = contentView.tag
        
    }
    
    private func moveAllRight(contentView : UIView){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            for x in contentView.subviews{
                x.center.x += 70
            }
            
            self.rightButtonDelete.center.x += 70
        }, completion: { _ in
            self.rightButtonDelete.isHidden = true
        })
        tagSelectedSwipe = -1
    }
    
    @objc func deleteRow(){
        let view = getView(withTag: tagSelectedSwipe)
        self.rightButtonDelete.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            view.center.x -= self.view.frame.width
            self.rightButtonDelete.center.x -= self.view.frame.width
        }, completion: { _ in
            view.removeFromSuperview()
        })
        moveUpAllViewAfter(tag: tagSelectedSwipe)
        
        Global.global.itemsOrder.remove(at: tagSelectedSwipe)
        tagSelectedSwipe = -1
        if(Global.global.itemsOrder.count <= 0){

        }
    }

    func getView(withTag: Int) -> UIView {
        for x in self.scrollView.subviews {
            if(x.tag == withTag) {
                return x
            }
        }
        return UIView()
    }
    
    func moveUpAllViewAfter(tag: Int) {
        var allViewToAnimate = [UIView]()
        for x in self.scrollView.subviews {
            if(x.tag > tag) {
                allViewToAnimate.append(x)
                x.tag -= 1
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            for x in allViewToAnimate{
                x.center.y -= allViewToAnimate[0].frame.height
            }
        }, completion: { _ in
            self.rightButtonDelete.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            var bigger: CGFloat = 0
            for x in self.scrollView.subviews {
                if(x.frame.maxY > bigger && !(x is UIImageView)) {
                    bigger = x.frame.maxY
                    print(x.classForCoder)
                }
            }
            
            self.scrollView.contentSize = CGSize(width: 0, height: bigger + 10 + 64)
        })
        isOpenLeft = false
        isOpenRight = false
        
    }
    
    @objc func toPay(){
        performSegue(withIdentifier: "toEndOrderFromCart", sender: nil)
    }
    
}
