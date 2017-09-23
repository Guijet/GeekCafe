//
//  ListAbonnement.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-22.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class ListAbonnement: UIViewController {
    let scrollView = UIScrollView()
    let backgroundView = UIImageView()
    var abonnement = [1,2,3,4]
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.setUpBackgroundImage(containerView: self.view)
        setNavigationTitle()
        setUpScrollView()
        fillScrollView()
    }

    //To make bar all white non translucent and appearing
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Liste Abonnements"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"Lato-Regular",size:rw(17))!, NSForegroundColorAttributeName:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }

    
    func fillScrollView(){
        var alpha:CGFloat = 1
        var newY = rh(28)
        if(abonnement.count > 0){
            for x in 0...abonnement.count - 1{
                let greenCard = UIView()
                greenCard.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(179))
                greenCard.backgroundColor = UIColor(red: 22.0 / 255.0, green: 233.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
                greenCard.layer.cornerRadius = rw(8)
                scrollView.addSubview(greenCard)
                
//                let logoBackGroundCard = UIImageView()
//                logoBackGroundCard.frame = CGRect(x: rw(257), y: rh(107), width: rw(111), height: rh(163))
//                logoBackGroundCard.image = UIImage(named: "geekAboonmentCard")
//                scrollView.addSubview(logoBackGroundCard)
//
//                let titleMember = UILabel()
//                titleMember.frame = CGRect(x: rw(28), y: rh(162), width: rw(184), height: rh(22))
//                titleMember.textColor = Utility().hexStringToUIColor(hex: "#FFFFFF")
//                titleMember.font = UIFont(name: "Lato-Regular", size: rw(18))
//                titleMember.textAlignment = .left
//                titleMember.text = "Membre premium"
//                scrollView.addSubview(titleMember)
//
//                let imageBrandText = UIImageView()
//                imageBrandText.frame = CGRect(x: rw(28.5), y: rh(183), width: rw(184), height: rh(33))
//                imageBrandText.image = UIImage(named: "titleAbonnementCard")
//                scrollView.addSubview(imageBrandText)
                newY += rh(206)
                alpha -= 0.20
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
}

extension UIView{
    func setGradientBackground(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [color1, color2]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
