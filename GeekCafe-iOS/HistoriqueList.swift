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
    var idToPass:Int!
    var historyToPass:HistoryList!
    
    
    override func viewDidLoad() {
        //Fill fake info
        //Set up menu and container
        super.viewDidLoad()
        arrayHistory = APIRequestHistory().getHisory()
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
                date.text = Utility().getCleanDate(date: x.date)//x.date
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
                price.text = "$ \(x.amount.floatValue.twoDecimal)"
                button.addSubview(price)
                
                Utility().createHR(x: 0, y: button.frame.height - 1, width: view.frame.width, view: button, color: Utility().hexStringToUIColor(hex: "#979797").withAlphaComponent(0.25))
                
                newY += rh(71)
                index += 1
                
            }
            scrollView.contentSize = CGSize(width: 1.0, height: newY)
        }
    }
    
    
    func historyChoose(sender:UIButton){
        idToPass = sender.tag
        getHistoryByID(id: sender.tag)
        performSegue(withIdentifier: "toInfoHistory", sender: nil)
    }
    
    func getHistoryByID(id:Int){
        if(arrayHistory.count > 0){
            for x in arrayHistory{
                if(id == x.id){
                    
                    historyToPass = x
                    break
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toInfoHistory"){
            (segue.destination as! InfoHistory).idToPass = self.idToPass
            (segue.destination as! InfoHistory).historyToPass = self.historyToPass
        }
    }
    
}

extension Float {
    var twoDecimal: String {
        return self .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.2f", self) : String(self)
    }
}
