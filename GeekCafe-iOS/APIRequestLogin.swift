//
//  APIRequestLogin.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-06.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestLogin{

    
    func login(password:String,email:String)->Bool{
        var worked:Bool = false
        var json:[String:Any] = Utility().getJson(url: "\(Global.global.ip!)token", method: "POST",body: "email=\(email)&password=\(password)")

        if let token = json["token"] as? String{
            Global.global.userInfo.token = token
            worked = true
        }
        return worked
    }
    
    func viewUser()->Bool{
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)user", method: "GET",needToken: true)
        if let user = json["data"] as? [String:Any]{
            
            let id = user["id"] as! Int
            let first_name = user["first_name"] as! String
            let last_name = user["last_name"] as! String
            let gender = user["gender"] as! String
            let email = user["email"] as! String
            let phone = user["phone"] as! String
            let birth_date = user["birth_date"] as! String
            let image_url = user["profile_image"] as! String
            let token = Global.global.userInfo.token
            
            Global.global.userInfo = User(firstname: first_name, lastname: last_name, email: email, sexe: gender, birthdate: birth_date, phone: phone, id: id, image_url: image_url, token: token)
            worked = true
        }
        return worked
    }
    
    func createAcount(first_name:String,last_name:String,gender:String,birth_date:String,phone:String,email:String,password:String)->Bool{
        
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)user", method: "POST",body: "first_name=\(first_name)&last_name=\(last_name)&gender=\(getGenderForRequest(gender:gender))&birth_date=\(birth_date)&phone=\(phone)&email=\(email)&password=\(password)")

        if let token = json["token"] as? String{
            
            let data = json["data"] as! [String:Any]
            let id = data["id"] as! Int
            let image_url = data["profile_image"] as! String
            Global.global.userInfo = User(firstname: first_name, lastname: last_name, email: email, sexe: gender, birthdate: birth_date, phone: phone, id: id, image_url: image_url, token: token)
            
            worked = true
        }
        return worked
    }
    
    func getGenderForRequest(gender:String)->String{
        if(gender == "Homme"){
            return "male"
        }
        else if(gender == "Femme"){
            return "female"
        }
        else if(gender == "Autre"){
            return "other"
        }
        return ""
    }
    
}
