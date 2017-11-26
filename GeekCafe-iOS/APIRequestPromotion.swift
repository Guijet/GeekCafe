//
//  APIRequestPromotion.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-25.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestPromotion{
    func getPromotions(page:String,stringRequest:String = "")->PromotionList{
        var arrayPromotions = [Promotion]()
        let json:[String:Any]!
        if(stringRequest == ""){
            json = Utility().getJson(url: "\(Global.global.ip!)promotions?page=\(page)", method: "GET",needToken:true)
        }
        else{
            json = Utility().getJson(url: "\(stringRequest)", method: "GET",needToken:true)
        }
        
        var nextPage:String!
        var isNext:Bool = false
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
                    var reductionT:String!
                    if let reduction = x["reduction"] as? String{
                        if(reduction.contains("%")){
                            reductionT = "\(reduction)"
                        }
                        else{
                            reductionT = "\(reduction.floatValue.twoDecimal)$"
                        }
                    }
                    else{
                        reductionT = "nil"
                    }
                    let item = x["item"] as! [String:Any]
                    let dataItem = item["data"] as! [String:Any]
                    arrayPromotions.append(Promotion(id: x["id"] as! Int, reduction: reductionT, image_url: dataItem["image"] as! String, code: "\(x["id"] as! Int)", itemName: dataItem["name"] as! String, nextPage: nextPage))
                }
            }
        }
        return PromotionList(promotions: arrayPromotions,meta: MetaPagination(nextString: nextPage, isNext: isNext))
    }
}
