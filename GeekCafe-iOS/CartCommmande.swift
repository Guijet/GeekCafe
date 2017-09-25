//
//  CartCommmande.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class CartCommmande: UIViewController {

    let backgroundImage = UIImageView()
    let scrollView = UIScrollView()
    var arrayItem = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillFakeInfosArray()
        setNavigationTitle()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setUpScrollView()
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"Lato-Regular",size:rw(17))!, NSForegroundColorAttributeName:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: ((view.frame.height - 64) - rh(75)))
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
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: rh(602), width: view.frame.width, height: rh(75))
        bottomView.backgroundColor = UIColor.white
        bottomView.makeShadow(x: 0, y: 2, blur: 4, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.40, spread: 5)
        view.addSubview(bottomView)
        
        let closeButton = UIButton()
        closeButton.createCreateButton(title: "Fermer", frame: CGRect(x: rw(21), y: rh(12), width: rw(129), height: rh(40)), fontSize: rw(20), containerView: bottomView)
        closeButton.addTarget(self, action: #selector(closeCart), for: .touchUpInside)
        
        let priceLabel = UILabel()
        priceLabel.createLabel(frame: CGRect(x: view.frame.midX, y: rh(14), width: (view.frame.width/2) - rw(30), height: rh(32)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(26), textAignment: .right, text: "$3.50")
        bottomView.addSubview(priceLabel)
    }
    
    func closeCart(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func fillFakeInfosArray(){
        
        arrayItem.append(Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Choco", price: "3.75"))
        arrayItem.append(Item(image: UIImage(named:"item3")!, type: "Drink", flavour: "Caramel", price: "7.50"))
        arrayItem.append(Item(image:UIImage(named:"item1")!, type: "Drink", flavour: "Vanille", price: "4.00"))
        arrayItem.append(Item(image: UIImage(named:"item3")!, type: "Drink", flavour: "Choco", price: "3.75"))
        arrayItem.append(Item(image: UIImage(named:"item2")!, type: "Drink", flavour: "Choco", price: "3.75"))
        arrayItem.append(Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Choco", price: "3.75"))
    }
}
