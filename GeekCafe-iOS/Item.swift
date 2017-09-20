//
//  Items.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-20.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Item{
    init(image:UIImage,type:String,flavour:String,price:String){
        self.image = image
        self.type = type
        self.flavour = flavour
        self.price = price
    }
    var image:UIImage
    var type:String
    var flavour:String
    var price:String
}
