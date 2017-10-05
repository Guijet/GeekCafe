//
//  MainPageProfile.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class MainPageProfile: UIViewController {

    let menu = MenuClass()
    let containerView = UIView()
    let scrollView = UIScrollView()
    let backgroundImage = UIImageView()
    let switchNotif = UISwitch()
    let titleOptions = ["Push Notifications","Modifier mon profil","Évaluez notre application","Termes et conditions","Niveaux"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Menu and container
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Profil")
        
        //Set Up Page
        setUpScrollView()
        setUpTopView()
        
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
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollView)
        
    }
    
    func setUpTopView(containerView:UIView){
        let profileImage = UIImageView()
        profileImage.frame = CGRect(x: rw(133), y: rh(32), width: rw(111), height: rw(111))
        profileImage.layer.cornerRadius = rw(111)/2
        profileImage.getOptimizeImageAsync(url: Global.global.userInfo.image_url)
        profileImage.layer.masksToBounds = true
        containerView.addSubview(profileImage)
    }

    func setUpTopView(){
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(270))
        topView.backgroundColor = UIColor.white
        topView.makeShadow(x: 0, y: 2, blur: 14, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        
        setUpTopView(containerView:topView)
        
        var newY:CGFloat = topView.frame.maxY
        var index:Int = 1
        
        for x in titleOptions{
            
            let buttonContainer = UIButton()
            buttonContainer.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: rh(82))
            buttonContainer.backgroundColor = UIColor.white
            buttonContainer.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            scrollView.addSubview(buttonContainer)
            
            let title = UILabel()
            title.createLabel(frame: CGRect(x:rw(14),y:rh(32),width:rw(250),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#303841"), fontName: "Lato-Regular", fontSize: rw(16), textAignment: .left, text: x)
            buttonContainer.addSubview(title)
            
            if(index == 1){
                
                switchNotif.frame = CGRect(x: view.frame.maxX - 82, y: buttonContainer.frame.height/2 - 15, width: 50, height: 30)
                //switchNotif.isUserInteractionEnabled = false
                switchNotif.backgroundColor = Utility().hexStringToUIColor(hex: "#E7E8E9")
                switchNotif.onTintColor = Utility().hexStringToUIColor(hex: "#7ED321")
                switchNotif.layer.cornerRadius = 16
                switchNotif.layer.borderWidth = 0.7
                switchNotif.layer.borderColor = Utility().hexStringToUIColor(hex: "#C7C7C7").cgColor
                Utility().createOverTapListener(x: switchNotif.frame.minX, y: switchNotif.frame.minY, width: switchNotif.frame.width, height: switchNotif.frame.height, view: buttonContainer, selector:#selector(switchValueDidChange) )
                buttonContainer.addSubview(switchNotif)
            }
            else{
                //METTRE UNE FLECHE
            }
            
            Utility().createHR(x: 0, y: buttonContainer.bounds.maxY - 1, width: view.frame.width, view: buttonContainer, color: Utility().hexStringToUIColor(hex: "#E7E8E9"))
            
            index += 1
            newY += rh(82)
        }
        scrollView.addSubview(topView)
        scrollView.contentSize = CGSize(width: 1.0, height: newY)
    }
    
    func switchValueDidChange(sender:UISwitch!) {
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    func buttonPressed(sender:UIButton){
        
    }
    
}
