//
//  FlavourCrepe.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class FlavourCrepe: UIViewController {

    let backgroundImage = UIImageView()
    let crepeImage = UIImageView()
    let bottomScrollView = UIScrollView()
    let LBL_Price = UILabel()

    var infoItem:Item!
    var price:NSNumber!
    var priceId:NSNumber!
    var nbChoix:Int!
    var nbSelectionChoix:Int = 0
    var subitemsIds = [NSNumber]()
    var initialPrice:Float = 0
    var isSetCancel:Bool = false
    var toppingID:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crêpe"
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        self.extendedLayoutIncludesOpaqueBars = true
        setUpImageCoffee()
        setUpTopPart()
        setUpBottom()
        fillScrollView()
        initialPrice = price.floatValue
    }
    
    func setUpTopPart(){
        
     
        LBL_Price.createLabel(frame: CGRect(x:rw(226),y:rh(86),width:rw(124),height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: price.floatValue.twoDecimal)
        view.addSubview(LBL_Price)
        
        let LBL_DTop1 = UILabel()
        LBL_DTop1.createLabel(frame: CGRect(x:rw(92),y:rh(100),width:rw(191),height:rh(36)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(15), textAignment: .center, text: "Recouvrement")
        view.addSubview(LBL_DTop1)
        
        let LBL_DTop2 = UILabel()
        LBL_DTop2.createLabel(frame: CGRect(x:0,y:rh(122),width:view.frame.width,height:rh(36)), textColor: Utility().hexStringToUIColor(hex: "#D6D6D6"), fontName: "Lato-Regular", fontSize: rw(13), textAignment: .center, text: "Glissez sur la crêpe le style de\n couvrement que vous désirez")
        LBL_DTop2.numberOfLines = 2
        view.addSubview(LBL_DTop2)
    }
    
    func setUpImageCoffee(){
        
        crepeImage.frame = CGRect(x: rw(41), y: rh(172), width: rw(294), height: rh(281))
        crepeImage.image = UIImage(named:"bigCrepe")
        crepeImage.contentMode = .scaleAspectFit
        self.view.addSubview(crepeImage)
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
                if(!x.isTopping){
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSubitem(sender:)))
                    let image = UIImageView()
                    image.isUserInteractionEnabled = true
                    image.addGestureRecognizer(tapGesture)
                    image.frame = CGRect(x: newX, y: rh(15), width: rw(70), height: rw(40))
                    image.layer.masksToBounds = false
                    image.contentMode = .scaleAspectFit
                    image.layer.cornerRadius = rw(25)
                    image.getOptimizeImageAsync(url: x.image)
                    image.tag = x.id
                    bottomScrollView.addSubview(image)
                    
                    let titleItem = UILabel()
                    titleItem.createLabel(frame: CGRect(x:image.frame.minX - rw(10),y:image.frame.maxY + rh(4),width:rw(90),height:rh(20)), textColor: Utility().hexStringToUIColor(hex: "666666"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: x.name)
                    titleItem.numberOfLines = 2
                    titleItem.lineBreakMode = .byTruncatingTail
                    bottomScrollView.addSubview(titleItem)
                
                    if(x.price != 0){
                        let additionnalPrice = UILabel()
                        additionnalPrice.createLabel(frame: CGRect(x:image.frame.minX,y:titleItem.frame.maxY,width:image.frame.width,height:rh(15)), textColor: Utility().hexStringToUIColor(hex: "D6D6D6"), fontName: "Lato-Regular", fontSize: rw(8), textAignment: .center, text: "( + \(x.price.floatValue.twoDecimal)$ )")
                        bottomScrollView.addSubview(additionnalPrice)
                    }
                
                    newX += rw(98)
                }
                
            }
            bottomScrollView.contentSize = CGSize(width: newX, height: 1.0)
            
        }
    }

    func getItemsForOrder()->itemOrder{
        var item:itemOrder!
        if(toppingID != 0){
            item = itemOrder(price_id: priceId, subItemIds: subitemsIds, image: infoItem.image, name: infoItem.name, type: infoItem.type, price:price,toppingId:toppingID)
        }
        else{
            item = itemOrder(price_id: priceId, subItemIds: subitemsIds, image: infoItem.image, name: infoItem.name, type: infoItem.type, price:price)
        }
        
        return item
    }
    
    
    @objc func tapSubitem(sender:UITapGestureRecognizer){
        if(nbSelectionChoix < nbChoix){
            let imageTag = sender.view!.tag
            updateBadge(imageViewSubitem:sender.view!)
            subitemsIds.append(imageTag as NSNumber)
            updatePriceSubitems(subItemId: imageTag)
            nbSelectionChoix += 1
        }
        else{
            Utility().alert(message: "Vous avez déja choisi vos \(nbChoix!) choix!", title: "Message", control: self)
        }
        
        if(subitemsIds.count > 0){
            if(!isSetCancel){
                setCancelButton()
            }
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
        containerBadge.frame = CGRect(x: rw(50), y: 0, width: rw(20), height: rw(20))
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
        isSetCancel = true
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
        price = initialPrice as NSNumber
        subitemsIds.removeAll()
        nbSelectionChoix = 0
        LBL_Price.text = initialPrice.twoDecimal
    }
    
    func removeBarCancelButton(){
        self.navigationItem.setRightBarButton(nil, animated: false)
        isSetCancel = false
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
                    let totalPrice = price.floatValue + x.price.floatValue
                    price = totalPrice as NSNumber
                    
                    LBL_Price.text = "\(price.floatValue.twoDecimal)"
                }
            }
        }
    }
    
    @objc func nextPressed(){
        Global.global.itemsOrder.append(getItemsForOrder())
        performSegue(withIdentifier: "toEndOrderFromCrepe", sender: nil)
    }
}
