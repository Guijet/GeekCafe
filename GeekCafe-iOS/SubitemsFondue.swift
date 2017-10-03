//
//  SubitemsFondue.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class SubitemsFondue: UIViewController {

    var arraySubitems = [Subitem]()
    
    let backgroundImage = UIImageView()
    let bolImage = UIImageView()
    let bottomScrollView = UIScrollView()
    let panGesture = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSubItems()
        self.title = "Crêpe"
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        self.extendedLayoutIncludesOpaqueBars = true
        setUpImageCoffee()
        setUpTopPart()
        setUpBottom()
        fillScrollView()
    }
    
    func setUpTopPart(){
        
        let LBL_Price = UILabel()
        LBL_Price.createLabel(frame: CGRect(x:rw(226),y:rh(86),width:rw(124),height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: "$8.00")
        view.addSubview(LBL_Price)
        
        let LBL_DTop1 = UILabel()
        LBL_DTop1.createLabel(frame: CGRect(x:rw(92),y:rh(100),width:rw(191),height:rh(36)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(15), textAignment: .center, text: "Ajouter des fruits")
        view.addSubview(LBL_DTop1)
        
        let LBL_DTop2 = UILabel()
        LBL_DTop2.createLabel(frame: CGRect(x:0,y:rh(122),width:view.frame.width,height:rh(36)), textColor: Utility().hexStringToUIColor(hex: "#D6D6D6"), fontName: "Lato-Regular", fontSize: rw(13), textAignment: .center, text: "Glissez sur la crêpe les fruits que vous désirez")
        LBL_DTop2.numberOfLines = 2
        view.addSubview(LBL_DTop2)
    }
    
    func setUpImageCoffee(){
        
        bolImage.frame = CGRect(x: rw(12), y: rh(158), width: rw(352), height: rh(352))
        bolImage.image = UIImage(named:"TableFondue")
        bolImage.contentMode = .scaleAspectFit
        self.view.addSubview(bolImage)
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
        if(arraySubitems.count > 0){
            
            for x in arraySubitems{
                
                let image = UIImageView()
                image.frame = CGRect(x: newX, y: rh(15), width: rw(60), height: rw(40))
                image.layer.masksToBounds = false
                image.contentMode = .scaleAspectFit
                image.layer.cornerRadius = rw(25)
                image.isUserInteractionEnabled = true
                image.addGestureRecognizer(panGesture)
                //image.image = x.image
                image.tag = x.id
                bottomScrollView.addSubview(image)
                
                
                
                let titleItem = UILabel()
                titleItem.createLabel(frame: CGRect(x:image.frame.minX - rw(15),y:image.frame.maxY + rh(4),width:rw(90),height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "666666"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: x.name)
                titleItem.numberOfLines = 2
                titleItem.lineBreakMode = .byTruncatingTail
                bottomScrollView.addSubview(titleItem)
                
                newX += rw(88)
            }
            bottomScrollView.contentSize = CGSize(width: newX, height: 1.0)
            
        }
    }
    
    func getSubItems(){
//        arraySubitems.append(Subitem(id: 1, image: UIImage(named:"fraise")!, name: "Fraise"))
//        arraySubitems.append(Subitem(id: 2, image: UIImage(named:"framboise")!, name: "Framboise"))
//        arraySubitems.append(Subitem(id: 3, image: UIImage(named:"banane")!, name: "Banane"))
//        arraySubitems.append(Subitem(id: 4, image: UIImage(named:"bleuet")!, name: "Bleut"))
    }
    
    func dragView(sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func nextPressed(){
        performSegue(withIdentifier: "toEndOrderFromFondue", sender: nil)
    }

}