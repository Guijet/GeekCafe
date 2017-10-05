//
//  Subitems.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-03.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Subitem{
    init(id:Int,name:String,price:NSNumber,image:String){
        self.id = id
        self.name = name
        self.price = price
        self.image = image
    }
    var id:Int
    var name:String
    var price:NSNumber
    var image:String
}
