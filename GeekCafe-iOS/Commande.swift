//
//  Commande.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-13.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Order{
    init(items:[itemOrder],card_pay:Bool, id_branch:Int,id_counter:Int){
        self.items = items
        self.card_pay = card_pay
        self.id_branch = id_branch
        self.id_counter = id_counter
    }
    var items:[itemOrder]
    var card_pay:Bool
    var id_branch:Int
    var id_counter:Int
}

struct itemOrder{
    init(price_id:NSNumber,subItemIds:[NSNumber],image:String,name:String,type:String,price:NSNumber){
        self.price_id = price_id
        self.subItemIds = subItemIds
        self.image = image
        self.name = name
        self.type = type
        self.price = price
    }
    var price_id:NSNumber
    var subItemIds:[NSNumber]
    var image:String
    var name:String
    var type:String
    var price:NSNumber
    
}
