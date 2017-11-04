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
    var subitemsIds = [NSNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crêpe"
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        self.extendedLayoutIncludesOpaqueBars = true
        setUpImageCoffee()
        setUpTopPart()
        setUpBottom()
        fillScrollView()
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
                titleItem.createLabel(frame: CGRect(x:image.frame.minX - rw(10),y:image.frame.maxY + rh(4),width:rw(90),height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "666666"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: x.name)
                titleItem.numberOfLines = 2
                titleItem.lineBreakMode = .byTruncatingTail
                bottomScrollView.addSubview(titleItem)
                
                newX += rw(98)
            }
            bottomScrollView.contentSize = CGSize(width: newX, height: 1.0)
            
        }
    }

    func getItemsForOrder()->itemOrder{
        let item = itemOrder(price_id: priceId, subItemIds: subitemsIds, image: infoItem.image, name: infoItem.name, type: infoItem.type, price:price)
        return item
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
                    let totalPrice = price.floatValue + x.price.floatValue
                    price = totalPrice as NSNumber
                    
                    LBL_Price.text = "\(price.floatValue.twoDecimal)"
                }
            }
        }
    }
    
    func nextPressed(){
        Global.global.itemsOrder.append(getItemsForOrder())
        performSegue(withIdentifier: "toEndOrderFromCrepe", sender: nil)
    }
}
