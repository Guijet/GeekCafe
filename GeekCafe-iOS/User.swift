//
//  User.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-06.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct User{
    init(firstname:String,lastname:String,email:String,sexe:String,birthdate:String,phone:String,id:Int,image_url:String,token:String,id_subscription:Int,points:Int,cards:[userCard]){
        self.firstname = firstname
        self.lastname = lastname
        self.birthdate = birthdate
        self.phone = phone
        self.email = email
        self.sexe = sexe
        self.id = id
        self.image_url = image_url
        self.token = token
        self.id_subscription = id_subscription
        self.points = points
        self.cards = cards
        
    }
    var id:Int
    var firstname:String
    var lastname:String
    var email:String
    var sexe:String
    var birthdate:String
    var phone:String
    var image_url:String
    var token:String
    var id_subscription:Int
    var points:Int
    var cards:[userCard]
    

}


