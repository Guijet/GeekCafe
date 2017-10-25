//
//  MainPageCredit.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class MainPageCredit: UIViewController {

    let menu = MenuClass()
    var arrayCards = [userCard]()
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            self.arrayCards = APIRequestLogin().indexPaymentsMethod(cardHolderName: "\(Global.global.userInfo.firstname) \(Global.global.userInfo.lastname)")
            DispatchQueue.main.async {
                self.menu.setUpMenu(view: self.view)
                self.setUpContainerView()
                self.menu.setUpFakeNavBar(view: self.containerView, titleTop: "Paiements")
                self.setUpScrollView()
                self.setUpBottomButton()
                self.fillScrollView()
            }
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setUpBottomButton(){
        let buttonAddCard = UIButton()
        buttonAddCard.frame = CGRect(x: 0, y: rh(601), width: view.frame.width, height: rh(66))
        buttonAddCard.backgroundColor = UIColor.white
        buttonAddCard.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        buttonAddCard.setTitle("Ajouter une carte", for: .normal)
        buttonAddCard.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonAddCard.addTarget(self, action: #selector(addCard), for: .touchUpInside)
        containerView.addSubview(buttonAddCard)
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - (64 + rh(66)))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var newY:CGFloat = rh(22)
        if(arrayCards.count > 0){
            for x in arrayCards{
                let containerButton = UIButton()
                containerButton.frame = CGRect(x: rw(8), y: newY, width: rw(360), height: rh(89))
                containerButton.addTarget(self, action: #selector(cardChoosen(sender:)), for: .touchUpInside)
                containerButton.backgroundColor = UIColor.white
                containerButton.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
                scrollView.addSubview(containerButton)
                
                let providerImage = UIImageView()
                providerImage.frame = CGRect(x: rw(16), y: rh(31), width: rw(68), height: rh(24))
                providerImage.image = UIImage(named:"visaList")
                providerImage.contentMode = .scaleAspectFit
                containerButton.addSubview(providerImage)
                
                let labelCardNumber = UILabel()
                labelCardNumber.frame = CGRect(x: rw(93), y: rh(27), width: rw(267), height: rh(30))
                labelCardNumber.text = "****    ****    ****    \(x.last4)"
                labelCardNumber.font = UIFont(name: "Lato-Light", size: rw(22))
                labelCardNumber.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                labelCardNumber.textAlignment = .center
                containerButton.addSubview(labelCardNumber)
                
                
                newY += rh(108)
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func cardChoosen(sender:UIButton){
        
    }
    
    func addCard(){
        
    }

    
}
