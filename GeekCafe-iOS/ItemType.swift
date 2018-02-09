//
//  ItemType.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-03.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct ItemType{
    init(id:Int,name:String,image:String){
        self.id = id
        self.name = name
        self.image = image
    }
    var id:Int
    var name:String
    var image:String
}
