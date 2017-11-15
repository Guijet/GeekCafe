//
//  ChooseSizeFondue.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class ChooseSizeFondue: UIViewController {

    var arrayButtons = [UIButton]()
    let backgroundImage = UIImageView()
    
    //Dashed Views
    var arrayDashedViews = [UIView]()
    let bigViewDashed = UIView()
    let middleViewDashed = UIView()
    let smallViewDashed = UIView()
    
    var listItemToPass:[ItemList]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        self.extendedLayoutIncludesOpaqueBars = true
        setUpTopPart()
        setDashedLines()
        resetDashedViews()
        setButtonAdd()
    }
    
    //To make bar all white non translucent and appearing
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Fondue"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpTopPart(){
        let LBL_Price = UILabel()
        LBL_Price.createLabel(frame: CGRect(x:rw(226),y:rh(86),width:rw(124),height:rh(24)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(20), textAignment: .right, text: "$8.00")
        view.addSubview(LBL_Price)
        
        let BTN_HeaderLeft = UIButton()
        BTN_HeaderLeft.tag = 1
        BTN_HeaderLeft.frame = CGRect(x: rw(62), y: rh(146), width: rw(72), height: rh(30))
        BTN_HeaderLeft.layer.borderColor = Utility().hexStringToUIColor(hex: "#D6D6D6").cgColor
        BTN_HeaderLeft.layer.borderWidth = 1
        BTN_HeaderLeft.layer.cornerRadius = rw(14)
        BTN_HeaderLeft.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        BTN_HeaderLeft.addTarget(self, action: #selector(buttonTopPressed(sender:)), for: .touchUpInside)
        BTN_HeaderLeft.setTitle("3 Choix", for: .normal)
        BTN_HeaderLeft.setTitleColor(Utility().hexStringToUIColor(hex: "#D6D6D6"), for: .normal)
        BTN_HeaderLeft.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(12))
        view.addSubview(BTN_HeaderLeft)
        
        let BTN_HeaderCenter = UIButton()
        BTN_HeaderCenter.tag = 2
        BTN_HeaderCenter.frame = CGRect(x: rw(152), y: rh(146), width: rw(72), height: rh(30))
        BTN_HeaderCenter.layer.borderColor = Utility().hexStringToUIColor(hex: "#D6D6D6").cgColor
        BTN_HeaderCenter.layer.borderWidth = 1
        BTN_HeaderCenter.layer.cornerRadius = rw(14)
        BTN_HeaderCenter.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        BTN_HeaderCenter.addTarget(self, action: #selector(buttonTopPressed(sender:)), for: .touchUpInside)
        BTN_HeaderCenter.setTitle("5 Choix", for: .normal)
        BTN_HeaderCenter.setTitleColor(Utility().hexStringToUIColor(hex: "#D6D6D6"), for: .normal)
        BTN_HeaderCenter.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(12))
        view.addSubview(BTN_HeaderCenter)
        
        let BTN_HeaderRight = UIButton()
        BTN_HeaderRight.tag = 3
        BTN_HeaderRight.frame = CGRect(x: rw(242), y: rh(146), width: rw(72), height: rh(30))
        BTN_HeaderRight.layer.borderColor = Utility().hexStringToUIColor(hex: "#D6D6D6").cgColor
        BTN_HeaderRight.layer.borderWidth = 1
        BTN_HeaderRight.layer.cornerRadius = rw(14)
        BTN_HeaderRight.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        BTN_HeaderRight.addTarget(self, action: #selector(buttonTopPressed(sender:)), for: .touchUpInside)
        BTN_HeaderRight.setTitle("7 Choix", for: .normal)
        BTN_HeaderRight.setTitleColor(Utility().hexStringToUIColor(hex: "#D6D6D6"), for: .normal)
        BTN_HeaderRight.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(12))
        view.addSubview(BTN_HeaderRight)
        
        arrayButtons = [BTN_HeaderLeft,BTN_HeaderCenter,BTN_HeaderRight]
    }
    
    
    func setDashedLines(){
        
        bigViewDashed.frame = CGRect(x: rw(48), y: rh(196), width: rw(280), height: rw(280))
        bigViewDashed.addDashedBorder(color: Utility().hexStringToUIColor(hex: "#D6D6D6"), lineWidth: 1, linePattern: [16,8.4])
        view.addSubview(bigViewDashed)
        
        
        middleViewDashed.frame = CGRect(x: rw(68), y: rw(214), width: rw(240), height: rw(240))
        middleViewDashed.addDashedBorder(color: Utility().hexStringToUIColor(hex: "#D6D6D6"), lineWidth: 1, linePattern: [16,8.4])
        view.addSubview(middleViewDashed)
        
        
        smallViewDashed.frame = CGRect(x: rw(88), y: rw(234), width: rw(200), height: rw(200))
        smallViewDashed.addDashedBorder(color: Utility().hexStringToUIColor(hex: "#D6D6D6"), lineWidth: 1, linePattern: [12,8])
        view.addSubview(smallViewDashed)
        
        arrayDashedViews = [bigViewDashed,middleViewDashed,smallViewDashed]
    }
    
    func setButtonAdd(){
        let buttonAdd = UIButton()
        buttonAdd.createCreateButton(title: "Ajouter", frame: CGRect(x:rw(88),y:rh(553),width:rw(202),height:rh(50)), fontSize: rw(20), containerView: self.view)
        buttonAdd.addTarget(self, action: #selector(buttonAddPressed), for: .touchUpInside)
    }
    
    @objc func buttonTopPressed(sender:UIButton){
        resetButtonStateTop()
        resetDashedViews()
        
        sender.backgroundColor = Utility().hexStringToUIColor(hex: "#16EA7C")
        sender.setTitleColor(Utility().hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        sender.layer.borderColor = Utility().hexStringToUIColor(hex: "#16EA7C").cgColor
        
        let viewToChanged = getDashedViewToChanged(tag: sender.tag)
        for x in viewToChanged.layer.sublayers!{
            if let sublayer = x as? CAShapeLayer{
                sublayer.strokeColor = Utility().hexStringToUIColor(hex: "#16E9A6").cgColor
                sublayer.lineWidth = 4
            }
        }
    }
    
    func resetButtonStateTop(){
        for x in arrayButtons{
            x.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
            x.setTitleColor(Utility().hexStringToUIColor(hex: "#D6D6D6"), for: .normal)
            x.layer.borderColor = Utility().hexStringToUIColor(hex: "#D6D6D6").cgColor
        }
    }
    
    func resetDashedViews(){
        for x in arrayDashedViews{
            if(x.layer.sublayers!.count > 0){
                for sublayer in x.layer.sublayers!{
                    if let l = sublayer as? CAShapeLayer{
                        l.strokeColor = Utility().hexStringToUIColor(hex: "#D6D6D6").cgColor
                        l.lineWidth = 1
                    }
                }
            }
        }
    }
    
    func getDashedViewToChanged(tag:Int)->UIView{
        if(tag == 3){
            return bigViewDashed
        }
        else if(tag == 2){
            return middleViewDashed
        }
        else{
            return smallViewDashed
        }
    }
    
    @objc func buttonAddPressed(){
        performSegue(withIdentifier: "toFlavourFondue", sender: nil)
    }

}
