//
//  APIRequestHistory.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestHistory{
    
    func getHisory()->[HistoryList]{
        var arrHistory = [HistoryList]()
        var json = Utility().getJson(url: "\(Global.global.ip!)user/history", method: "GET",needToken:true)
        if let data = json["data"] as? [[String:Any]]{
            if(data.count > 0){
                for x in data{
                    arrHistory.append(HistoryList(date: (x["created_at"] as! [String:Any])["date"] as! String, country: "Canada", city: "Boisbriand", amount: x["amount"] as! NSNumber, id: x["id"] as! Int))
                }
            }
            return arrHistory
        }
        else{
            return arrHistory
        }
    }

    func getItemFromOrderID(id:Int)->[itemInfo]{
        var itemsinlist = [itemInfo]()
        var json = Utility().getJson(url: "\(Global.global.ip!)order/\(id)", method: "GET",needToken:true)

        if let data = json["data"] as? [String:Any]{
            
            //METTRE LES SUBITEMS PRICE DANS LE PRIX TOAL DE LITEM
            let items = data["items"] as! [String:Any]
            let dataItems = items["data"] as! [[String:Any]]
            if(dataItems.count > 0){
                for x in dataItems{
                    itemsinlist.append(itemInfo(price: x["price"] as! NSNumber, image_url: x["image"] as! String, name: x["name"] as! String, type: x["type"] as! String))
                }
            }

        }
        return itemsinlist
    }
}
