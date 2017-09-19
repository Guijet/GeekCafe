//
//  PromotionMainPage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class PromotionMainPage: UIViewController {

    //Menu and container
    let menu = MenuClass()
    let containerView = UIView()
    var arrayPromotions = [Promotion]()
    
    //Pages element
    let backgroundImage = UIImageView()
    let scrollViewPromotion = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Menu and container
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Promotions")
        
        //Page set up
        backgroundImage.setUpBackgroundImage(containerView: containerView)
        setUpScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setUpScrollView(){
        scrollViewPromotion.frame = containerView.frame
        scrollViewPromotion.backgroundColor = UIColor.clear
        scrollViewPromotion.showsVerticalScrollIndicator = false
        scrollViewPromotion.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollViewPromotion)
    }
    
    func fillFakeInformation(){
        arrayPromotions.append(Promotion(item: "Café", discount: 50, image: UIImage(named:"")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "Café", discount: 25, image: UIImage(named:"")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "Café", discount: 10, image: UIImage(named:"")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "Café", discount: 20, image: UIImage(named:"")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "Café", discount: 70, image: UIImage(named:"")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "Café", discount: 65, image: UIImage(named:"")!, code: "12345678", id: 1))
        arrayPromotions.append(Promotion(item: "Café", discount: 30, image: UIImage(named:"")!, code: "12345678", id: 1))
    }

}
