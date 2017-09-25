//
//  Abonnement.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-23.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Abonnement{
    init(id:Int,title:String,description:String,nbFreeCoffees:Int,percentage:Int,rationCoin:String){
        self.title = title
        self.id = id
        self.description = description
        self.nbFreeCoffees = nbFreeCoffees
        self.percentage = percentage
        self.rationCoin = rationCoin
    }
    var id:Int
    var title:String
    var description:String
    var nbFreeCoffees:Int
    var percentage:Int
    var rationCoin:String
}
