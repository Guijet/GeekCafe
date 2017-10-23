//
//  BackgroundView.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-23.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    fileprivate let LBL_Title = UILabel()
    fileprivate let LBL_Subtitle = UILabel()
    fileprivate let bgCard = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Utility().hexStringToUIColor(hex: "#6CA642")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpElements(containerView:UIView){
        setUpTopImage(containerView:containerView)
        setUpTopLabels(containerView: containerView)
        buildCard(containerView: containerView)
    }
    
    func resizeCard(containerView:UIView,newHeight:CGFloat,newY:CGFloat){
        AnimationsLogin().resizeCard(containerView: containerView, cardView: bgCard, newHeight: newHeight, newYpos: newY)
    }
    
    fileprivate func setUpTopImage(containerView:UIView){
        let logo = UIImageView()
        logo.frame = CGRect(x: containerView.rw(135), y: containerView.rh(46), width: containerView.rw(111), height: containerView.rh(106))
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named:"logoLogin")
        self.addSubview(logo)
    }
    
    fileprivate func setUpTopLabels(containerView:UIView){
        
        LBL_Title.createLabel(frame: CGRect(x:containerView.rw(55),y:containerView.rh(197),width:containerView.rw(266),height:containerView.rh(27)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Bold", fontSize: containerView.rw(35), textAignment: .center, text: "Bienvenue")
        self.addSubview(LBL_Title)
        
        
        LBL_Subtitle.createLabel(frame: CGRect(x:containerView.rw(55),y:LBL_Title.frame.maxY,width:containerView.rw(266),height:containerView.rh(43)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Regular", fontSize: containerView.rw(12), textAignment: .center, text: "Connectez-nous pour continuer.")
        self.addSubview(LBL_Subtitle)
    }
    
    fileprivate func buildCard(containerView:UIView){
        
        bgCard.frame = CGRect(x: containerView.rw(21), y: containerView.rh(320), width: containerView.rw(334), height: containerView.rh(352))
        bgCard.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        bgCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 5, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        self.addSubview(bgCard)
        
    }
}
