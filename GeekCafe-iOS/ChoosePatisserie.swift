//
//  PatisserieInfo.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-25.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class ChoosePatisserie: UIViewController{

    let backgroudImage = UIImageView()
    let containerView = UIView()
    let labelNumberItems = UILabel()
    var yAt:CGFloat = 0
    var numberOfItems:Int = 1
    
    var infoItem:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Muffin"
        backgroudImage.setUpBackgroundImage(containerView: self.view)
        setUpContainer()
        setUpPrice()
        setUpImage()
        setUpUpButtonsArrow()
        setUpButtonAdd()
    }
    
    func setUpContainer(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.clear
        view.addSubview(containerView)
    }
    
    func setUpPrice(){
        let LBL_Price = UILabel()
        LBL_Price.createLabel(frame: CGRect(x:view.frame.width/2,y:rh(22),width:(view.frame.width/2) - rw(25.3),height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: String(format: "$%.2f", infoItem.prices[0].price.floatValue))
        containerView.addSubview(LBL_Price)
    }
    
    func setUpImage(){
        let imageItems = UIImageView()
        imageItems.frame = CGRect(x: (view.frame.width/2) - rw(95), y: rw(80.45), width: rw(190), height: rw(190))
        imageItems.getOptimizeImageAsync(url: infoItem.image)
        containerView.addSubview(imageItems)
        
        let titleItem = UILabel()
        titleItem.createLabel(frame: CGRect(x: rw(23), y: imageItems.frame.maxY + rh(24), width: view.frame.width - rw(46), height: rh(28)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(23), textAignment: .left, text: infoItem.name)
        containerView.addSubview(titleItem)
        
        let description = UILabel()
        description.createLabel(frame: CGRect(x: rw(22), y: titleItem.frame.maxY + rh(8), width: view.frame.width - rw(44), height: rh(80)), textColor: Utility().hexStringToUIColor(hex: "#919191"), fontName: "Lato-Regular", fontSize: rw(16), textAignment: .left, text: infoItem.description)
        description.numberOfLines = 4
        description.lineBreakMode = .byTruncatingHead
        containerView.addSubview(description)
        
        yAt = description.frame.maxY
    }
    
    func setUpUpButtonsArrow(){
        let buttonLeft = UIButton()
        buttonLeft.frame = CGRect(x: rw(53), y: yAt + rh(39), width: rw(43), height: rw(43))
        buttonLeft.backgroundColor = UIColor.white
        buttonLeft.addTarget(self, action: #selector(leftPressed), for: .touchUpInside)
        buttonLeft.makeShadow(x: 0, y: 5, blur: 10, cornerRadius: buttonLeft.frame.width/2, shadowColor: UIColor.black, shadowOpacity: 0.35, spread: 0)
        buttonLeft.imageEdgeInsets = UIEdgeInsets(top: rh(11), left: rw(16), bottom: rh(11), right: rw(16))
        buttonLeft.setImage(UIImage(named:"leftArrow"), for: .normal)
        
        
        let buttonRight = UIButton()
        buttonRight.frame = CGRect(x: rw(277), y: yAt + rh(39), width: rw(43), height: rw(43))
        buttonRight.backgroundColor = UIColor.white
        buttonRight.setImage(UIImage(named:"rightArrow"), for: .normal)
        buttonRight.imageEdgeInsets = UIEdgeInsets(top: rh(11), left: rw(16), bottom: rh(11), right: rw(16))
        buttonRight.addTarget(self, action: #selector(rightPressed), for: .touchUpInside)
        buttonRight.makeShadow(x: 0, y: 5, blur: 10, cornerRadius: buttonRight.frame.width/2, shadowColor: UIColor.black, shadowOpacity: 0.35, spread: 0)
        
        
        labelNumberItems.createLabel(frame: CGRect(x: rw(139), y: yAt + rh(18), width: rw(96), height: rw(60)), textColor: Utility().hexStringToUIColor(hex: "#666666"), fontName: "Lato-Light", fontSize: rw(50), textAignment: .center, text: String(numberOfItems))
        
        
        
        let LBL_Quantite = UILabel()
        LBL_Quantite.createLabel(frame: CGRect(x: rw(116), y: labelNumberItems.frame.maxY, width: view.frame.width - rw(232), height: rw(19)), textColor: Utility().hexStringToUIColor(hex: "#666666"), fontName: "Lato-Light", fontSize: rw(16), textAignment: .center, text: "Quantité")
        
        containerView.addSubview(labelNumberItems)
        containerView.addSubview(LBL_Quantite)
        containerView.addSubview(buttonLeft)
        containerView.addSubview(buttonRight)
        
        yAt = LBL_Quantite.frame.maxY
    }
    
    func setUpButtonAdd(){
        let buttonAdd = UIButton()
        buttonAdd.createCreateButton(title: "Ajouter", frame: CGRect(x:rw(88),y:yAt + rh(22),width:rw(202),height:rh(50)), fontSize: rw(20), containerView: containerView)
        buttonAdd.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    }
    
    func leftPressed(){
        if(numberOfItems > 1){
            numberOfItems -= 1
            labelNumberItems.text = String(numberOfItems)
        }
    }
    
    func rightPressed(){
        if(numberOfItems < 99){
            numberOfItems += 1
            labelNumberItems.text = String(numberOfItems)
        }
    }
    
    func addItem(){
        performSegue(withIdentifier: "patisserieToEndOrder", sender: nil)
    }
    
    

}
