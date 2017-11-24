//
//  loadingIndicator.swift
//  TLA-Project
//
//  Created by Guillaume Jette on 2017-08-27.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class loadingIndicator{
    
    fileprivate let activity = UIActivityIndicatorView()
    fileprivate let backgroundView = UIView()
    
    func buildViewAndStartAnimate(view:UIView){
        backgroundView.frame = view.frame
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)
        
        activity.frame = CGRect(x: view.frame.midX - ((view.frame.width / 4) / 2), y: view.frame.midY - ((view.frame.width / 4) / 2), width: view.frame.width / 4, height: view.frame.width / 4)
        activity.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        activity.color = Utility().hexStringToUIColor(hex: "#7ED321")
        activity.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        backgroundView.addSubview(activity)
        activity.startAnimating()
    }
    
    func stopAnimatingAndRemove(view:UIView){
        activity.stopAnimating()
        activity.removeFromSuperview()
        backgroundView.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
}
