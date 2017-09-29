//
//  HistoryList.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct HistoryList{
    init(date:String,country:String,city:String,amount:String,id:Int,items:[Item]){
        self.date = date
        self.city = city
        self.country = country
        self.amount = amount
        self.id = id
        self.items = items
    }
    var date:String
    var country:String
    var city:String
    var amount:String
    var id:Int
    var items:[Item]
}
