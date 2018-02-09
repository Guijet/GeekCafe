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
                    var createdAt:String!
                    if let info = x["created_at"] as? [String:Any]{
                        if let createdAtS = info["date"] as? String{
                            createdAt = createdAtS
                        }
                        else{
                            createdAt = "Unknown"
                        }
                    }
                    else{
                        createdAt = "Unknown"
                    }
                    var amount:NSNumber!
                    if let amountN = x["amount"] as? NSNumber{
                        amount = amountN
                    }
                    if let amountS = x["amount"] as? String{
                        amount = NumberFormatter().number(from: amountS)
                    }
                    var idHisory:Int!
                    if let idHistoryN = x["id"] as? Int{
                        idHisory = idHistoryN
                    }
                    if let idHistoryS = x["id"] as? String{
                        idHisory = Int(idHistoryS)
                    }
                    //TODO: TAKE CITY AND COUNTR FROM RESTAURANT THAT I ORDERED
                    arrHistory.append(HistoryList(date:createdAt, country: "Canada", city: "Boisbriand", amount: amount, id: idHisory))
                }
            }
        }
        return HistoryListMeta(Historic: arrHistory, Meta: MetaPagination(nextString: nextPage, isNext: isNext))
    }

    func getItemFromOrderID(id:Int)->[itemInfo]{
        var itemsinlist = [itemInfo]()
        var json = Utility().getJson(url: "\(Global.global.ip!)order/\(id)", method: "GET",needToken:true)
        var subItemsPrice:Float = 0
        if let data = json["data"] as? [String:Any]{
            
            if let items = data["items"] as? [String:Any]{
                if let dataItems = items["data"] as? [[String:Any]]{
                    if(dataItems.count > 0){
                        for x in dataItems{
                            var price:NSNumber!
                            if let priceN = x["price"] as? NSNumber{
                                price = priceN
                            }
                            if let priceS = x["price"] as? String{
                                price = NumberFormatter().number(from: priceS)
                            }
                            
                            var image:String!
                            if let imageS = x["image"] as? String{
                                image = imageS
                            }
                            else{
                                image = "unknown image"
                            }
                            
                            var name:String!
                            if let nameS = x["name"] as? String{
                                name = nameS
                            }
                            else{
                                name = "unknown image"
                            }
                            
                            var type:String!
                            if let typeS = x["type"] as? String{
                                type = typeS
                            }
                            else{
                                type = "unknown image"
                            }
                            if let subitems = x["subitems"] as? [String:Any]{
                                if let dataSubItems = subitems["data"] as? [[String:Any]]{
                                    if(dataSubItems.count > 0){
                                        for x in dataSubItems{
                                            if let priceSubItemsN = x["price"] as? NSNumber{
                                                subItemsPrice += priceSubItemsN.floatValue
                                            }
                                            else if let priceSubItemsS = x["price"] as? String{
                                                subItemsPrice += NSString(string:priceSubItemsS).floatValue
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            itemsinlist.append(itemInfo(price: price, image_url: image, name: name, type: type, subItemsPrice: subItemsPrice as NSNumber))
                        }
                    }
                }
            }
            
            

        }
        return itemsinlist
    }
}
