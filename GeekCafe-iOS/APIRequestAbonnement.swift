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
                    var points_rewards:NSNumber!
                    if let rewards = x["point_reward"] as? NSNumber{
                        points_rewards = rewards
                    }
                    if let rewardsS = x["point_reward"] as? String{
                        points_rewards = NumberFormatter().number(from: rewardsS)
                    }
                    
                    var discount:NSNumber!
                    if let discountN = x["discount"] as? NSNumber{
                        discount = discountN
                    }
                    if let discountS = x["discount"] as? String{
                        discount = NumberFormatter().number(from: discountS)
                    }
                    
                    var price:NSNumber!
                    if let priceN = x["price"] as? NSNumber{
                        price = priceN
                    }
                    if let priceS = x["price"] as? String{
                        price = NumberFormatter().number(from: priceS)
                    }
                    
                    var idAbonnement:Int!
                    if let idN = x["id"] as? Int{
                        idAbonnement = idN
                    }
                    if let idS = x["id"] as? String{
                        idAbonnement = Int(idS)
                    }
                    var title:String!
                    if let titleS = x["title"] as? String{
                        title = titleS
                    }
                    else{
                        title = "unknown title"
                    }
                    var description:String!
                    if let descriptionS = x["title"] as? String{
                        description = descriptionS
                    }
                    else{
                        description = "unknown description"
                    }
                    var perk:String!
                    if let perkS = x["title"] as? String{
                        perk = perkS
                    }
                    else{
                        perk = "unknown perk"
                    }
                    arraySubs.append(Abonnement(id: idAbonnement, title: title, description: description, perk:perk, point_reward: points_rewards, discount: discount, price: price))
                }
            }
        }
        return arraySubs
    }
    
    func modifyAbonnement(id_sub:Int){
       
        let json = Utility().getJson(url: "\(Global.global.ip!)user", method: "PUT",body: "subscription_id=\(id_sub)",needToken: true)
        
        if let data = json["data"] as? [String:Any]{
            if let x = data["subscription"] as? [String:Any]{
                var points_rewards:NSNumber!
                if let rewards = x["point_reward"] as? NSNumber{
                    points_rewards = rewards
                }
                if let rewardsS = x["point_reward"] as? String{
                    points_rewards = NumberFormatter().number(from: rewardsS)
                }
                
                var discount:NSNumber!
                if let discountN = x["discount"] as? NSNumber{
                    discount = discountN
                }
                if let discountS = x["discount"] as? String{
                    discount = NumberFormatter().number(from: discountS)
                }
                
                var price:NSNumber!
                if let priceN = x["price"] as? NSNumber{
                    price = priceN
                }
                if let priceS = x["price"] as? String{
                    price = NumberFormatter().number(from: priceS)
                }
                
                var idAbonnement:Int!
                if let idN = x["id"] as? Int{
                    idAbonnement = idN
                }
                if let idS = x["id"] as? String{
                    idAbonnement = Int(idS)
                }
                var title:String!
                if let titleS = x["title"] as? String{
                    title = titleS
                }
                else{
                    title = "unknown title"
                }
                var description:String!
                if let descriptionS = x["title"] as? String{
                    description = descriptionS
                }
                else{
                    description = "unknown description"
                }
                var perk:String!
                if let perkS = x["title"] as? String{
                    perk = perkS
                }
                else{
                    perk = "unknown perk"
                }
                Global.global.userInfo.abonnement = Abonnement(id: idAbonnement, title: title, description: description, perk: perk, point_reward: points_rewards, discount: discount, price: price)
            }
        }
    }
}
