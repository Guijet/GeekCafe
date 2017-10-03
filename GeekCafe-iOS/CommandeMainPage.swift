//
//  CommandeMainPage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class CommandeMainPage: UIViewController {
    
    let menu = MenuClass()
    let containerView = UIView()
    
    let backgroundGeek = UIImageView()
    let scrollView = UIScrollView()
    var arrayItems = [ItemType]()
    
    var listItemToPass:[ItemList]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Menu set up
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Commandes")
        
        //Page Set UP
        arrayItems = APIRequestCommande().getItemTypes()
        backgroundGeek.setUpBackgroundImage(containerView: self.containerView)
        setUpScrollView()
        fillScrollView()
        createButton()
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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clear
        containerView.addSubview(scrollView)
    }
    
    //We need good images
    func fillScrollView(){
        if(arrayItems.count > 0){
            var index:Int = 1
            //Y position of items
            var newY:CGFloat = rh(26)
            
            //2 Column X position
            let firstX:CGFloat = rh(28)
            let secondX:CGFloat = rh(209)
            
            for x in arrayItems{
                //Button Set up
                let buttonItem = UIButton()
                if((index % 2) == 1){
                    buttonItem.frame = CGRect(x: firstX, y: newY, width: rw(139), height: rw(139))
                }
                else{
                    buttonItem.frame = CGRect(x: secondX, y: newY, width: rw(139), height: rw(139))
                    newY += rh(175)
                }
                buttonItem.backgroundColor = UIColor.white
                buttonItem.makeShadow(x: 0, y: 2, blur: 4, cornerRadius: 10, shadowColor: UIColor.black, shadowOpacity: 0.27, spread: 0)
                buttonItem.tag = x.id
                buttonItem.accessibilityIdentifier = x.name
                buttonItem.addTarget(self, action: #selector(goToOrder(sender:)), for: .touchUpInside)
                scrollView.addSubview(buttonItem)
                
                //Image in button
                let imageItem = UIImageView()
                imageItem.frame = CGRect(x: rw(25), y: rh(15), width: rw(90), height: rw(90))
                imageItem.getOptimizeImageAsync(url: x.image)
                buttonItem.addSubview(imageItem)
                
                let titleItem = UILabel()
                titleItem.createLabel(frame: CGRect(x: 0, y: rh(110), width: buttonItem.frame.width, height: rh(25)), textColor: Utility().hexStringToUIColor(hex: "#6CA642"), fontName: "Lato-Regular", fontSize: rw(17), textAignment: .center, text: x.name)
                buttonItem.addSubview(titleItem)
                
                index += 1
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    func createButton(){
        let doneButton = UIButton()
        doneButton.createCreateButton(title: "Afficher ma commande", frame: CGRect(x: rw(73), y: rh(513), width: rw(230), height: rh(54)), fontSize: rw(20), containerView: scrollView)
        doneButton.addTarget(self, action: #selector(seeOrder(sender:)), for: .touchUpInside)
    }
    
    func seeOrder(sender:UIButton){
        performSegue(withIdentifier: "toSeeCommande", sender: nil)
    }
    
    func goToOrder(sender:UIButton){
        
        listItemToPass = APIRequestCommande().getItemsList(id: sender.tag)
        
        if(sender.accessibilityIdentifier == "Cafés"){
            performSegue(withIdentifier: "toBreuvage", sender: nil)
        }
        else if(sender.accessibilityIdentifier == "Pâtisseries"){
            performSegue(withIdentifier: "toPatisserie", sender: nil)
        }
        else if(sender.accessibilityIdentifier == "Crêpes"){
            performSegue(withIdentifier: "toCrepe", sender: nil)
        }
        else if(sender.accessibilityIdentifier == "Fondues"){
            performSegue(withIdentifier: "toFondue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toBreuvage"){
            (segue.destination as! BrevageMain).listItemToPass = self.listItemToPass
        }
        else if(segue.identifier == "toPatisserie"){
            (segue.destination as! PatisserieMain).listItemToPass = self.listItemToPass
        }
        else if(segue.identifier == "toCrepe"){
            (segue.destination as! ChooseSizeCrepe).listItemToPass = self.listItemToPass
        }
        else if(segue.identifier == "toFondue"){
            (segue.destination as! ChooseSizeFondue).listItemToPass = self.listItemToPass
        }
        
    }
    
    
    

}
