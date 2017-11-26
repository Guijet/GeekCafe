//
//  APIRequestAbonnement.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestAbonnement{
    func getAllAbonnement()->[Abonnement]{
        var arraySubs = [Abonnement]()
        let json = Utility().getJson(url: "\(Global.global.ip!)subscriptions", method: "GET",needToken:true)
        if let subscriptions = json["subscriptions"] as? [[String:Any]]{
            
            if(subscriptions.count > 0){
                for x in subscriptions{
                    arraySubs.append(Abonnement(id: x["id"] as! Int, title: x["title"] as! String, description: x["description"] as! String, perk: x["perk"] as! String, point_reward: x["point_reward"] as! NSNumber, discount: x["discount"] as! NSNumber, price: x["price"] as! NSNumber))
                }
            }
        }
        return arraySubs
    }
    
    func modifyAbonnement(id_sub:Int){
       
        let json = Utility().getJson(url: "\(Global.global.ip!)user", method: "PUT",body: "subscription_id=\(id_sub)",needToken: true)
        
        if let data = json["data"] as? [String:Any]{
            let subscription = data["subscription"] as! [String:Any]
            print(subscription)
            var idT:Int!
            if let id = subscription["id"] as? Int{
                idT = id
            }
            else if let id = subscription["id"] as? String{
                idT = Int(id)
            }
            Global.global.userInfo.abonnement = Abonnement(id: idT, title: subscription["title"] as! String, description: subscription["description"] as! String, perk: subscription["perk"] as! String, point_reward: subscription["point_reward"] as! NSNumber, discount: subscription["discount"] as! NSNumber, price: subscription["price"] as! NSNumber)
        }
    }
}
