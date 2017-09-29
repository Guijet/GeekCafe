//
//  ItemCommande.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-23.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class ItemCommande{
    init(id:Int,type:String,image:UIImage){
        self.id = id
        self.type = type
        self.image = image
    }
    var image:UIImage
    var type:String
    var id:Int
}
