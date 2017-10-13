//
//  Commande.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-13.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Commande{
    init(price_id:Int,subItemsID:[Int]){
        self.price_id = price_id
        self.subItemsID = subItemsID
    }
    var price_id:Int
    var subItemsID:[Int]
}
