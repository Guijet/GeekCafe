//
//  Promotion.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Promotion{
    init(id:Int,reduction:String,image_url:String,code:String,itemName:String){
        self.id = id
        self.code = code
        self.image_url = image_url
        self.reduction = reduction
        self.itemName = itemName

    }
    var id:Int
    var reduction:String
    var image_url:String
    var code:String
    var itemName:String

}



struct PromotionList{
    init(promotions:[Promotion]){
        self.promotions = promotions
    }
    var promotions:[Promotion]
}
