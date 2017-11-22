//
//  Promotion.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Promotion{
    init(id:Int,reduction:NSNumber,image_url:String,code:String,itemName:String,nextPage:String){
        self.id = id
        self.code = code
        self.image_url = image_url
        self.reduction = reduction
        self.itemName = itemName
        self.nextPage = nextPage
    }
    var id:Int
    var reduction:NSNumber
    var image_url:String
    var code:String
    var itemName:String
    var nextPage:String
}



struct PromotionList{
    init(promotions:[Promotion],meta:MetaPagination){
        self.meta = meta
        self.promotions = promotions
    }
    var promotions:[Promotion]
    var meta:MetaPagination
}
