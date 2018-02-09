//
//  HistoryList.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct HistoryList{
    init(date:String,country:String,city:String,amount:NSNumber,id:Int){
        self.date = date
        self.city = city
        self.country = country
        self.amount = amount
        self.id = id
    }
    var date:String
    var country:String
    var city:String
    var amount:NSNumber
    var id:Int
}

struct HistoryListMeta{
    
    init(Historic:[HistoryList],Meta:MetaPagination){
        self.Historic = Historic
        self.Meta = Meta
    }
    var Historic:[HistoryList]
    var Meta:MetaPagination
    
}
