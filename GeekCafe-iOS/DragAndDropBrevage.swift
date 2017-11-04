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
    }
    
    func setUpTopPart(){
        
        
        LBL_Price.createLabel(frame: CGRect(x:rw(226),y:rh(86),width:rw(124),height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: "\(priceItem.floatValue.twoDecimal)")
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
                image.frame = CGRect(x: newX, y: rh(15), width: rw(50), height: rw(50))
                image.layer.masksToBounds = true
                image.layer.cornerRadius = rw(25)
                image.getOptimizeImageAsync(url: x.image)
                image.tag = x.id
                bottomScrollView.addSubview(image)
                
                let titleItem = UILabel()
                titleItem.createLabel(frame: CGRect(x:image.frame.minX,y:image.frame.maxY + rh(6),width:image.frame.width,height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "666666"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: x.name)
                titleItem.numberOfLines = 2
                titleItem.lineBreakMode = .byTruncatingTail
                bottomScrollView.addSubview(titleItem)
                
                newX += rw(91.7)
            }
            bottomScrollView.contentSize = CGSize(width: newX, height: 1.0)
            
        }
    }
    
    func getItemsForOrder()->itemOrder{
        let item = itemOrder(price_id: priceId, subItemIds: subitemsIds, image: infoItem.image, name: infoItem.name, type: infoItem.type, price: priceItem)
        return item
    }
    
    func dragView(sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func tapSubitem(sender:UITapGestureRecognizer){
        let imageTag = sender.view!.tag
        updateBadge(containerView:sender.view!)
        subitemsIds.append(imageTag as NSNumber)
        updatePriceSubitems(subItemId: imageTag)
        print(imageTag)
    }
    
    func updateBadge(containerView:UIView){
        let containerBadge = UIView()
        containerBadge.frame = CGRect(x: containerView.frame.maxX - rw(12), y: containerView.frame.minY, width: rw(20), height: rw(20))
        containerBadge.backgroundColor = UIColor.red
        containerBadge.layer.cornerRadius = rw(10)
        containerView.superview!.addSubview(containerBadge)
    }
    
    func updatePriceSubitems(subItemId:Int){
        if(infoItem.subitems.count > 0){
            for x in infoItem.subitems{
                if(x.id == subItemId){
                    let totalPrice = priceItem.floatValue + x.price.floatValue
                    priceItem = totalPrice as NSNumber
                    
                    LBL_Price.text = "\(priceItem.floatValue.twoDecimal)"
                }
            }
        }
        
    }
    
    func nextPressed(){
        Global.global.itemsOrder.append(getItemsForOrder())
        performSegue(withIdentifier: "toEndOrderFromBrevage", sender: nil)
    }
    
    
    
}
