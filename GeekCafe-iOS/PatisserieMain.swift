//
//  PatisserieMain.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class PatisserieMain: UIViewController{

    let scrollView = UIScrollView()
    let backgroundImage = UIImageView()
    
    var listItemToPass:[ItemList]!
    var infoItem:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        backgroundImage.setUpBackgroundImage(containerView: self.view)
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
        self.title = "Pâtisseries"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpScrollView(){
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var index:Int = 1
        let firstX:CGFloat = rw(14.5)
        let secondX:CGFloat = rw(138.5)
        let thirdX:CGFloat = rw(252.5)
        
        var newY:CGFloat = rh(15)
        
        if(listItemToPass.count > 0){
            for x in listItemToPass{
                let containerButton = UIButton()
                containerButton.backgroundColor = UIColor.clear
                containerButton.tag = x.id
                containerButton.addTarget(self, action: #selector(patisseriePressed(sender:)), for: .touchUpInside)
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
                    newY += rh(160)
                }
                
                let imagePatisserie = UIImageView()
                imagePatisserie.frame = CGRect(x: ((containerButton.frame.width/2) - rw((70/2))), y: rh(9), width: rw(70), height: rh(82))
                imagePatisserie.getOptimizeImageAsync(url: x.image)
                containerButton.addSubview(imagePatisserie)
                
                let titlePatisserie = UILabel()
                titlePatisserie.createLabel(frame: CGRect(x: 0, y: imagePatisserie.frame.maxY + rh(7), width: containerButton.frame.width, height: rw(40)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Regular", fontSize: rw(13), textAignment: .center, text: x.name)
                titlePatisserie.numberOfLines = 2
                titlePatisserie.lineBreakMode = .byWordWrapping
                containerButton.addSubview(titlePatisserie)
                
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
    
    @objc func patisseriePressed(sender:UIButton){
        infoItem = APIRequestCommande().getItemInfo(item_id: sender.tag)
        performSegue(withIdentifier: "toChoosePatisserie", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toChoosePatisserie"){
            (segue.destination as! ChoosePatisserie).infoItem = self.infoItem
        }
    }

}
