//
//  Animations.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-21.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class AnimationsLogin{
    
    func animateItemsLeft(containerView:UIView,itemToMove:UIView){
        containerView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            itemToMove.center.x -= containerView.frame.width
            
        }, completion: { _ in
            containerView.isUserInteractionEnabled = true
        })
    }
    
    func animateItemsRight(containerView:UIView,items:[UIView]){
        containerView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            for x in items{
                x.center.x += containerView.frame.width
            }
        }, completion: { _ in
            containerView.isUserInteractionEnabled = true
        })
    }
    
    func resizeCard(containerView:UIView,cardView:UIView,newHeight:CGFloat,newYpos:CGFloat){
        containerView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            cardView.frame.origin.y = newYpos
            cardView.frame.size.height = newHeight
        }, completion: { _ in
            containerView.isUserInteractionEnabled = true
        })
    }
}
