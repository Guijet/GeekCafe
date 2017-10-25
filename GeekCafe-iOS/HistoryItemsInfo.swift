//
//  HistoryItemsInfo.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-24.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct itemInfo{
    init(price:NSNumber,image_url:String,name:String,type:String){
        self.price = price
        self.image_url = image_url
        self.name = name
        self.type = type
    }
    var price:NSNumber
    var image_url:String
    var name:String
    var type:String
}
