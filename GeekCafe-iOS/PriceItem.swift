//
//  PriceItem.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-03.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct PriceItem{
    init(id:Int,price:NSNumber,size:String){
        self.id = id
        self.price = price
        self.size = size
    }
    var id:Int
    var price:NSNumber
    var size:String
}
