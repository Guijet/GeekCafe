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
    
    func setUpElements(containerView:UIView,frameImageTop:CGRect, frameFirstLabel:CGRect,frameCard:CGRect,text1:String,text2:String){
        setUpTopImage(containerView:containerView, frame: frameImageTop)
        setUpTopLabels(containerView: containerView,frameFirstLabel:frameFirstLabel, text1: text1,text2:text2)
        buildCard(containerView: containerView, frameCard: frameCard)
    }
    
    func resizeCard(containerView:UIView,newHeight:CGFloat,newY:CGFloat){
        AnimationsLogin().resizeCard(containerView: containerView, cardView: bgCard, newHeight: newHeight, newYpos: newY)
    }
    
    fileprivate func setUpTopImage(containerView:UIView,frame:CGRect){
        let logo = UIImageView()
        logo.frame = frame
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named:"Topimage")
        self.addSubview(logo)
    }
    
    fileprivate func setUpTopLabels(containerView:UIView,frameFirstLabel:CGRect,text1:String,text2:String){
        
        LBL_Title.createLabel(frame: frameFirstLabel, textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Bold", fontSize: containerView.rw(35), textAignment: .center, text: text1)
        self.addSubview(LBL_Title)
        
        
        LBL_Subtitle.createLabel(frame: CGRect(x:containerView.rw(55),y:LBL_Title.frame.maxY,width:containerView.rw(266),height:containerView.rh(43)), textColor: Utility().hexStringToUIColor(hex: "#E9E9E9"), fontName: "Lato-Regular", fontSize: containerView.rw(12), textAignment: .center, text: text2)
        self.addSubview(LBL_Subtitle)
    }
    
    fileprivate func buildCard(containerView:UIView,frameCard:CGRect){
        
        bgCard.frame = frameCard
        bgCard.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
        bgCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 5, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        self.addSubview(bgCard)
        
    }
}
