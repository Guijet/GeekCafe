//
//  BrevageMain.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct breuvage{
    init(id:Int,name:String,image:UIImage){
        self.id = id
        self.name = name
        self.image = image
    }
    var id:Int
    var name:String
    var image:UIImage
}

class BrevageMain: UIViewController {

    var arrayBreuvage = [breuvage]()
    let backgroundImage = UIImageView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
        setUpScrollView()
        fillArrayBreuvage()
        setUpScrollViewBreuvage()
    }
    
    //To make bar all white non translucent and appearing
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Breuvages"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"Lato-Regular",size:rw(17))!, NSForegroundColorAttributeName:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }
    
    func setUpScrollViewBreuvage(){
        var index:Int = 1
        //17.5
        let firstX:CGFloat = rw(34.5)
        let secondX:CGFloat = rw(138.5)
        let thirdX:CGFloat = rw(242.5)
        
        var newY:CGFloat = rh(10)
        
        if(arrayBreuvage.count > 0){
            for x in arrayBreuvage{
                let containerButton = UIButton()
                containerButton.backgroundColor = UIColor.clear
                containerButton.tag = x.id
                containerButton.addTarget(self, action: #selector(drinkPressed(sender:)), for: .touchUpInside)
                if(index == 1){
                    containerButton.frame = CGRect(x: firstX, y: newY, width: rw(100), height: rh(140))
                    index = 2
                }
                else if(index == 2){
                    containerButton.frame = CGRect(x: secondX, y: newY, width: rw(100), height: rh(140))
                    index = 3
                }
                else if(index == 3){
                    containerButton.frame = CGRect(x: thirdX, y: newY, width: rw(100), height: rh(140))
                    index = 1
                    newY += rh(151)
                }
                
                let imageDrink = UIImageView()
                imageDrink.frame = CGRect(x: ((containerButton.frame.width/2) - rw((65/2))), y: 0, width: rw(65), height: rw(100))
                imageDrink.image = x.image
                containerButton.addSubview(imageDrink)
                
                let titleDrink = UILabel()
                titleDrink.createLabel(frame: CGRect(x: 0, y: imageDrink.frame.maxY + rh(7), width: containerButton.frame.width, height: rw(15)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(13), textAignment: .center, text: x.name)
                containerButton.addSubview(titleDrink)
                
                scrollView.addSubview(containerButton)
            }
            if(index == 2 || index == 3){
                scrollView.contentSize = CGSize(width: 1.0, height: newY + rh(151))
            }
            else{
                scrollView.contentSize = CGSize(width: 1.0, height: newY)
            }
        }
    }
    
    func drinkPressed(sender:UIButton){
        print(sender.tag)
    }
    
    func fillArrayBreuvage(){
        for x in 1...13{
            arrayBreuvage.append(breuvage(id: x, name: "breuvage\(x)", image: UIImage(named:"breuvageListimg")!))
        }
    }
    
    

}