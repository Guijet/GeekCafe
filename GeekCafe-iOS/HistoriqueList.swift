//
//  HistoriqueList.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class HistoriqueList: UIViewController {

    //Menu and container
    let menu = MenuClass()
    let containerView = UIView()
    
    //Historique
    let scrollView = UIScrollView()
    var arrayHistory = [HistoryList]()
    var structToPass:HistoryList = HistoryList(date: "", country: "", city: "", amount: "", id: 0, items: [Item]())
    
    override func viewDidLoad() {
        //Fill fake info
        fillFakeInfo()
        
        //Set up menu and container
        super.viewDidLoad()
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Historique")
        
        //Page Setup
        setUpScrollView()
        fillScrollView()
    }

    //Hide real nav bar for menu
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //Container to add
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
    
    func setUpScrollView(){
        scrollView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        containerView.addSubview(scrollView)
    }
    
    func fillScrollView(){
        var newY:CGFloat = 0
        var index:Int = 0
        if(arrayHistory.count > 0){
            for x in arrayHistory{
                
                let button = UIButton()
                button.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: rh(71))
                if(index % 2 == 0){button.backgroundColor = Utility().hexStringToUIColor(hex: "#FFFFFF")}
                else{button.backgroundColor = Utility().hexStringToUIColor(hex: "#FBFBFB")}
                button.addTarget(self, action: #selector(historyChoose(sender:)), for: .touchUpInside)
                button.tag = x.id
                scrollView.addSubview(button)
                
                let date = UILabel()
                date.frame = CGRect(x: rw(27), y: rh(20), width: view.frame.midX - rw(27), height: rh(18))
                date.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                date.font = UIFont(name: "Lato-Regular", size: rw(15))
                date.textAlignment = .left
                date.text = x.date
                button.addSubview(date)
                
                let location = UILabel()
                location.frame = CGRect(x: rw(27), y: date.frame.maxY + rh(2), width: view.frame.midX - rw(27), height: rh(13))
                location.textColor = Utility().hexStringToUIColor(hex: "#D6D6D6")
                location.font = UIFont(name: "Lato-Regular", size: rw(13))
                location.textAlignment = .left
                location.text = "\(x.city), \(x.country)"
                button.addSubview(location)
                
                let price = UILabel()
                price.frame = CGRect(x: view.frame.midX, y: rh(26), width: view.frame.midX - rw(17), height: rh(18))
                price.textColor = Utility().hexStringToUIColor(hex: "#AFAFAF")
                price.font = UIFont(name: "Lato-Regular", size: rw(18))
                price.textAlignment = .right
                price.text = "$ \(x.amount)"
                button.addSubview(price)
                
                Utility().createHR(x: 0, y: button.frame.height - 1, width: view.frame.width, view: button, color: Utility().hexStringToUIColor(hex: "#979797").withAlphaComponent(0.25))
                
                newY += rh(71)
                index += 1
                
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    
    func historyChoose(sender:UIButton){
        getHistoryByID(id: sender.tag)
        performSegue(withIdentifier: "toInfoHistory", sender: nil)
    }
    
    func getHistoryByID(id:Int){
        if(arrayHistory.count > 0){
            for x in arrayHistory{
                if(id == x.id){
                    structToPass = x
                    break
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toInfoHistory"){
            (segue.destination as! InfoHistory).structToPass = self.structToPass
        }
    }
    
    func fillFakeInfo(){
        
        let item1 = Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Choco", price: "3.75")
        let item2 = Item(image: UIImage(named:"item3")!, type: "Drink", flavour: "Caramel", price: "7.50")
        let item3 = Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Vanille", price: "4.00")
        let item4 = Item(image: UIImage(named:"item2")!, type: "Drink", flavour: "Nature", price: "2.50")
        let item5 = Item(image: UIImage(named:"item3")!, type: "Drink", flavour: "Nature", price: "2.50")
        let item6 = Item(image: UIImage(named:"item1")!, type: "Drink", flavour: "Caramel", price: "2.50")
        let item7 = Item(image: UIImage(named:"item2")!, type: "Drink", flavour: "Nature", price: "2.50")
        
        let arrayItems:[Item] = [item1,item2,item3,item4,item4,item4,item4,item5,item6,item7]
        
        arrayHistory.append(HistoryList(date: "21 août 2017", country: "Canada", city: "Boisbriand", amount: "4.50", id: 1, items: arrayItems))
        arrayHistory.append(HistoryList(date: "28 août 2017", country: "Canada", city: "Blainville", amount: "5.00", id: 2,items: arrayItems))
        arrayHistory.append(HistoryList(date: "04 août 2017", country: "Canada", city: "Rosemère", amount: "12.50", id: 3,items: arrayItems))
        arrayHistory.append(HistoryList(date: "14 août 2017", country: "Canada", city: "Laval", amount: "1.50", id: 4,items: arrayItems))
        arrayHistory.append(HistoryList(date: "10 août 2017", country: "Canada", city: "Montreal", amount: "7.50", id: 5,items: arrayItems))
        arrayHistory.append(HistoryList(date: "21 août 2017", country: "Canada", city: "Rosemère", amount: "1.75", id: 6,items: arrayItems))
        arrayHistory.append(HistoryList(date: "21 août 2017", country: "Canada", city: "Laval", amount: "12.75", id: 7,items: arrayItems))
        arrayHistory.append(HistoryList(date: "04 août 2017", country: "Canada", city: "Blainville", amount: "1.50", id: 8,items: arrayItems))
        arrayHistory.append(HistoryList(date: "14 août 2017", country: "Canada", city: "Boisbriand", amount: "55.30", id: 9,items: arrayItems))
        arrayHistory.append(HistoryList(date: "14 août 2017", country: "Canada", city: "Boisbriand", amount: "55.30", id: 10,items: arrayItems))
    }
    
}
