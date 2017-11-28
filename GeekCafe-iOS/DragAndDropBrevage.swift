//
//  DragAndDropBrevage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class DragAndDropBrevage: UIViewController{
    
    let LBL_Price = UILabel()
    let backgroundImage = UIImageView()
    let coffeImage = UIImageView()
    let bottomScrollView = UIScrollView()
    let panGesture = UIPanGestureRecognizer()
    
    //View Items all info
    var infoItem:Item!
    var typeItem:String!
    var priceItem:NSNumber!
    var priceId:NSNumber!
    var nbChoix:Int!
    var initialPrice:Float = 0
    var subitemsIds = [NSNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Café"
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        self.extendedLayoutIncludesOpaqueBars = true
        setUpImageCoffee()
        setUpTopPart()
        setUpBottom()
        fillScrollView()
        initialPrice = priceItem.floatValue
    }
    
    func setUpTopPart(){
        
        
        LBL_Price.createLabel(frame: CGRect(x:rw(226),y:rh(86),width:rw(124),height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: "$\(priceItem.floatValue.twoDecimal)")
        view.addSubview(LBL_Price)
        
        let LBL_DTop1 = UILabel()
        LBL_DTop1.createLabel(frame: CGRect(x:rw(92),y:rh(94),width:rw(191),height:rh(36)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(15), textAignment: .center, text: "Que mettez-vous dans\nvotre café?")
        LBL_DTop1.numberOfLines = 2
        view.addSubview(LBL_DTop1)
        
        let LBL_DTop2 = UILabel()
        LBL_DTop2.createLabel(frame: CGRect(x:0,y:rh(137),width:view.frame.width,height:rh(36)), textColor: Utility().hexStringToUIColor(hex: "#D6D6D6"), fontName: "Lato-Regular", fontSize: rw(13), textAignment: .center, text: "Glissez dans votre tasse ce que vous désirez")
        view.addSubview(LBL_DTop2)
    }
    
    func setUpImageCoffee(){
       
        coffeImage.frame = CGRect(x: 0, y: rh(165), width: view.frame.width, height: rh(419))
        coffeImage.image = UIImage(named:"bigCoffe")
        coffeImage.contentMode = .scaleAspectFit
        self.view.addSubview(coffeImage)
    }
    
    func setUpBottom(){
        
        bottomScrollView.frame = CGRect(x: 0, y: rh(567), width: view.frame.width - rw(69), height: rh(100))
        bottomScrollView.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        bottomScrollView.showsVerticalScrollIndicator = false
        bottomScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(bottomScrollView)
        
        let rightView = UIView()
        rightView.frame = CGRect(x: rw(306), y: rh(567), width: rw(69), height: rh(100))
        rightView.makeShadow(x: -7, y: 0, blur: 12, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.32, spread: 0)
        rightView.backgroundColor = UIColor.white
        view.addSubview(rightView)
        
        let buttonRight = UIButton()
        buttonRight.frame = CGRect(x: rw(15), y: rh(28), width: rw(44), height: rw(44))
        buttonRight.backgroundColor = Utility().hexStringToUIColor(hex: "#16E9A6")
        buttonRight.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: rw(44)/2, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        buttonRight.setImage(UIImage(named:"right-arrow_white"), for: .normal)
        buttonRight.imageEdgeInsets = UIEdgeInsets(top: rh(2), left: rw(17), bottom: rh(2), right: rw(9.3))
        buttonRight.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        
        rightView.addSubview(buttonRight)
    }
    
    func fillScrollView(){
        var newX:CGFloat = rw(33)
        if(infoItem.subitems.count > 0){
            
            for x in infoItem.subitems{
                let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(tapSubitem(sender:)))
                let image = UIImageView()
                image.isUserInteractionEnabled = true
                image.addGestureRecognizer(tapGestureImage)
                image.frame = CGRect(x: newX, y: rh(10), width: rw(50), height: rw(50))
                //image.layer.masksToBounds = true
                //image.layer.cornerRadius = rw(25)
                image.getOptimizeImageAsync(url: x.image)
                image.tag = x.id
                bottomScrollView.addSubview(image)
                
                let titleItem = UILabel()
                titleItem.createLabel(frame: CGRect(x:image.frame.minX,y:image.frame.maxY,width:image.frame.width,height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "666666"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: x.name)
                titleItem.numberOfLines = 2
                titleItem.lineBreakMode = .byTruncatingTail
                bottomScrollView.addSubview(titleItem)
                
                if(x.price != 0){
                    let additionnalPrice = UILabel()
                    additionnalPrice.createLabel(frame: CGRect(x:image.frame.minX,y:titleItem.frame.maxY,width:image.frame.width,height:rh(15)), textColor: Utility().hexStringToUIColor(hex: "D6D6D6"), fontName: "Lato-Regular", fontSize: rw(8), textAignment: .center, text: "( + \(x.price.floatValue.twoDecimal)$ )")
                    bottomScrollView.addSubview(additionnalPrice)
                }
                
                
                newX += rw(91.7)
            }
            bottomScrollView.contentSize = CGSize(width: newX, height: 1.0)
            
        }
    }
    
    func getItemsForOrder()->itemOrder{
        let item = itemOrder(price_id: priceId, subItemIds: subitemsIds, image: infoItem.image, name: infoItem.name, type: infoItem.type, price: priceItem)
        return item
    }
    

    @objc func tapSubitem(sender:UITapGestureRecognizer){
        let imageTag = sender.view!.tag
        updateBadge(imageViewSubitem:sender.view!)
        subitemsIds.append(imageTag as NSNumber)
        updatePriceSubitems(subItemId: imageTag)
        if(subitemsIds.count > 0){
            setCancelButton()
        }
    }
    
    func updateBadge(imageViewSubitem:UIView){
        if(!isSetBadge(imageView: imageViewSubitem)){
            buildBadgeView(imageViewSubitem: imageViewSubitem)
        }
        else{
            updateBadgeLabel(imageView: imageViewSubitem)
        }
    }
    
    func buildBadgeView(imageViewSubitem:UIView){
        let containerBadge = UIView()
        containerBadge.frame = CGRect(x: rw(30), y: 0, width: rw(20), height: rw(20))
        containerBadge.backgroundColor = Utility().hexStringToUIColor(hex: "#00DEAD")
        containerBadge.layer.cornerRadius = rw(10)
        containerBadge.accessibilityIdentifier = "Badge"
        imageViewSubitem.addSubview(containerBadge)
        
        let lbl_number = UILabel()
        lbl_number.frame = CGRect(x: 0, y: 0, width: rw(20), height: rw(20))
        lbl_number.accessibilityIdentifier = "NumberItems"
        lbl_number.textAlignment = .center
        lbl_number.text = "1"
        lbl_number.tag = 1
        lbl_number.textColor = UIColor.white
        lbl_number.font = UIFont(name:"Lato-Light",size:rw(11))
        containerBadge.addSubview(lbl_number)
    }
    
    func updateBadgeLabel(imageView:UIView){
        for x in imageView.subviews{
            if let badge = x as? UIView{
                for y in badge.subviews{
                    if let lbl = y as? UILabel{
                        lbl.tag += 1
                        lbl.text = "\(lbl.tag)"
                    }
                }
            }
        }
    }
    
    func setCancelButton(){
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(resetSubItems))
        self.navigationItem.rightBarButtonItem = cancel
    }
    
    @objc func resetSubItems(){
        for x in bottomScrollView.subviews{
            for y in x.subviews{
                if let badge = y as? UIView{
                    if(badge.accessibilityIdentifier == "Badge"){
                        badge.removeFromSuperview()
                    }
                }
            }
        }
        removeBarCancelButton()
        priceItem = initialPrice as NSNumber
        subitemsIds.removeAll()
        LBL_Price.text = "$\(initialPrice.twoDecimal)"
    }
    
    func removeBarCancelButton(){
        self.navigationItem.setRightBarButton(nil, animated: false)
    }
    
    func isSetBadge(imageView:UIView)->Bool{
        if(imageView.subviews.count > 0){
            return true
        }
        else{
            return false
        }
    }
    
    func updatePriceSubitems(subItemId:Int){
        
        if(infoItem.subitems.count > 0){
            for x in infoItem.subitems{
                if(x.id == subItemId){
                    let totalPrice = priceItem.floatValue + x.price.floatValue
                    priceItem = totalPrice as NSNumber
                    
                    LBL_Price.text = "$\(priceItem.floatValue.twoDecimal)"
                }
            }
        }
        
    }
    
    @objc func nextPressed(){
        Global.global.itemsOrder.append(getItemsForOrder())
        performSegue(withIdentifier: "toEndOrderFromBrevage", sender: nil)
    }
    
    
    
}
