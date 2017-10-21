//
//  CustomTextfield.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-21.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
class CustomTextField:UITextField,UITextFieldDelegate{
    
    let placeholderLabel = UILabel()
    let separator = UIView()
    
    init(placeholderText:String,containerView:UIView,xPos:CGFloat,yPos:CGFloat){
        super.init(frame: CGRect.zero)
        buildViews(placeholderText: placeholderText, containerView: containerView, xPos: xPos, yPos: yPos)
    }
    
    fileprivate func buildViews(placeholderText:String,containerView:UIView,xPos:CGFloat,yPos:CGFloat){
        
        //Instantiate textfield base
        self.frame = CGRect(x: xPos, y: yPos, width: containerView.rw(272), height: containerView.rh(32))
        self.delegate = self
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.font = UIFont(name:"Lato-Bold",size:containerView.rw(16))
        self.textAlignment = .left
        containerView.addSubview(self)
        
        //Instantiate custom text field placeholder
        
        placeholderLabel.frame = CGRect(x: self.frame.minX, y: (self.frame.midY - containerView.rh(10)), width: self.frame.width, height: containerView.rh(20))
        placeholderLabel.textAlignment = .left
        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont(name:"Lato-Bold",size:containerView.rw(16))
        containerView.addSubview(placeholderLabel)
        
        
        separator.frame = CGRect(x: self.frame.minX, y: self.frame.maxY + 5, width: self.frame.width, height: 1)
        separator.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
        containerView.addSubview(separator)
    }
   
    fileprivate func animateLabel(){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.placeholderLabel.frame.origin = CGPoint(x:self.frame.minX,y:self.frame.minY - 12)
        } ,completion:{ _ in
            print("DONE")
        })
    }
    
    func resetLabelInPlace(){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.placeholderLabel.frame.origin = CGPoint(x:self.frame.minX,y:self.frame.minY + 12)
        } ,completion:{ _ in
            print("DONE")
        })
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateLabel()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(self.text == ""){
            resetLabelInPlace()
        }
    }
    
    func getAllItems()->[UIView]{
        return [placeholderLabel,separator]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

