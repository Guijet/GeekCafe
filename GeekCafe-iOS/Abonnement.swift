//
//  Abonnement.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-23.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Abonnement{
    init(id:Int,title:String,description:String,perk:String,point_reward:NSNumber,discount:NSNumber,price:NSNumber){
        self.title = title
        self.id = id
        self.description = description
        self.perk = perk
        self.point_reward = point_reward
        self.discount = discount
        self.price = price
    }
    var id:Int
    var title:String
    var description:String
    var perk:String
    var point_reward:NSNumber
    var discount:NSNumber
    var price:NSNumber
}
