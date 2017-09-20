//
//  Promotion.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Promotion{
    init(item:String,discount:Int,image:UIImage,code:String,id:Int){
        self.item = item
        self.discount = discount
        self.image = image
        self.id = id
        self.code = code
    }
    
    var item:String
    var discount:Int
    var image:UIImage
    var id:Int
    var code:String
}
