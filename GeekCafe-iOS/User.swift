//
//  User.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-06.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct User{
    init(firstname:String,lastname:String,email:String,sexe:String,birthdate:String,phone:String,card:userCard){
        self.firstname = firstname
        self.lastname = lastname
        self.birthdate = birthdate
        self.phone = phone
        self.email = email
        self.sexe = sexe
        self.card = card
    }
    var firstname:String
    var lastname:String
    var email:String
    var sexe:String
    var birthdate:String
    var phone:String
    var card:userCard
}

struct userCard{
    init(last4:String,validMonth:String,validYear:String,expMonth:String,expYear:String,brand:String,name:String){
        self.last4 = last4
        self.validYear = validYear
        self.validMonth = validMonth
        self.expMonth = expMonth
        self.expYear = expYear
        self.brand = brand
        self.name = name
    }
    
    var last4:String
    var validMonth:String
    var validYear:String
    var expMonth:String
    var expYear:String
    var brand:String
    var name:String
    
}
