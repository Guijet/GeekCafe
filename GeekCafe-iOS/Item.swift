//
//  Items.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-20.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Item{
    init(id:Int,description:String,type:String,image:String,name:String,prices:[PriceItem],subitems:[Subitem]){
        self.id = id
        self.description = description
        self.type = type
        self.name = name
        self.image = image
        self.prices = prices
        self.subitems = subitems
    }
    var id:Int
    var description:String
    var type:String
    var name:String
    var image:String
    var prices:[PriceItem]
    var subitems:[Subitem]
}
