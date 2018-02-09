//
//  userCard.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-03.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit


struct userCard{
    
    init(last4:String,expMonth:String,expYear:String,brand:String,name:String,id_card:String){
        self.last4 = last4
        self.expMonth = expMonth
        self.expYear = expYear
        self.brand = brand
        self.name = name
        self.id_card = id_card
    }
    
    var id_card:String
    var last4:String
    var expMonth:String
    var expYear:String
    var brand:String
    var name:String
    
    
}
