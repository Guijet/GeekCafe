//
//  APIRequestHistory.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestHistory{
    
    func getHisory(page:String,stringRequest:String = "")->HistoryListMeta{
        var arrHistory = [HistoryList]()
        var nextPage:String!
        var isNext:Bool = false
        var json:[String:Any]!
        if(stringRequest == ""){
            json = Utility().getJson(url: "\(Global.global.ip!)user/history?page=\(page)", method: "GET",needToken:true)
        }
        else{
            json = Utility().getJson(url: "\(stringRequest)", method: "GET",needToken:true)
        }
        if let meta = json["meta"] as? [String:Any]{
            if let pagination = meta["pagination"] as? [String:Any]{
                if let links = pagination["links"] as? [String:Any]{
                    if let next = links["next"] as? String{
                        nextPage = next
                        isNext = true
                        
                    }else{
                        nextPage = ""
                    }
                }
                if let _ = pagination["links"] as? [[String:Any]]{
                    nextPage = ""
                }
            }
            
        }
        if let data = json["data"] as? [[String:Any]]{
            if(data.count > 0){
                for x in data{
                    arrHistory.append(HistoryList(date: (x["created_at"] as! [String:Any])["date"] as! String, country: "Canada", city: "Boisbriand", amount: x["amount"] as! NSNumber, id: x["id"] as! Int))
                }
            }
        }
        return HistoryListMeta(Historic: arrHistory, Meta: MetaPagination(nextString: nextPage, isNext: isNext))
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
