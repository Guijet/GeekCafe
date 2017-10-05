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
            saveToken(token: token)
            worked = true
        }
        return worked
    }
    
    func viewUser()->Bool{
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)user", method: "GET",needToken: true)
        if let user = json["data"] as? [String:Any]{
            var phoneUser:String!
            let id = user["id"] as! Int
            let first_name = user["first_name"] as! String
            let last_name = user["last_name"] as! String
            let gender = user["gender"] as! String
            let email = user["email"] as! String
            if let phone = user["phone"] as? String{
                phoneUser = phone
            }
            else{
                phoneUser = ""
            }
            let birth_date = user["birth_date"] as! String
            let image_id = user["profile_image"] as! String
            let image_url = "\(Global.global.ip!)image/\(image_id)"
            
            
            let token = Global.global.userInfo.token
            
            Global.global.userInfo = User(firstname: first_name, lastname: last_name, email: email, sexe: gender, birthdate: birth_date, phone: phoneUser, id: id, image_url: image_url, token: token, cards: [userCard]())
            worked = true
        }
        return worked
    }
    
    func createAcount(first_name:String,last_name:String,gender:String,birth_date:String,phone:String,email:String,password:String)->Bool{
        
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)user", method: "POST",body: "first_name=\(first_name)&last_name=\(last_name)&gender=\(getGenderForRequest(gender:gender))&birth_date=\(birth_date)&phone=\(phone)&email=\(email)&password=\(password)")

        if let token = json["token"] as? String{
            saveToken(token: token)
            let data = json["data"] as! [String:Any]
            let id = data["id"] as! Int
            let image_url = data["profile_image"] as! String
            Global.global.userInfo = User(firstname: first_name, lastname: last_name, email: email, sexe: gender, birthdate: birth_date, phone: phone, id: id, image_url: image_url, token: token,cards:[userCard]())
            
            
            worked = true
        }
        return worked
    }
    
    func verifyEmail(email:String)->Bool{
        var isOK:Bool = true
        var json = Utility().getJson(url: "\(Global.global.ip!)verify", method: "POST",body: "email=\(email)")
        if let _ = json["errors"] as? [String:Any]{
            isOK = false
        }
        return isOK
    }
    
    func addPaymentMethod(card_token:String)->Bool{
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)user/payment", method: "POST",body: "card_token=\(card_token)",needToken: true)
        if let _ = json["status"]{
            worked = true
        }
        return worked
    }
    
    func indexPaymentsMethod(cardHolderName:String)->[userCard]{
        var arrayCards:[userCard] = [userCard]()
        var json = Utility().getJson(url: "\(Global.global.ip!)user/payments", method: "GET",needToken:true)
        
        if let cards = json["cards"] as? [[String:Any]]{
            if(cards.count > 0){
                for x in 0...cards.count - 1{
                    let a = userCard(last4: cards[x]["last4"] as! String, expMonth: String(cards[x]["exp_month"] as! Int), expYear: String(cards[x]["exp_year"] as! Int), brand: cards[x]["brand"] as! String, name: cardHolderName)
                    arrayCards.append(a)
                }
            }
        }
        return arrayCards
    }
    
    func verifyToken(token:String)->Bool{
        var isSaved:Bool = false
        
        var json = Utility().getJson(url: "\(Global.global.ip!)verifytoken?token=\(token)", method: "POST")
        
        if let _ = json["user"] as? [String:Any]{
            isSaved = true
            Global.global.userInfo.token = token
        }
        
        return isSaved
    }
    
    func facebookRequest(accessToken:String)->Bool{
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)loginfacebook", method: "POST",body:"access_token=\(accessToken)")
        
        var idUser:Int!
        var token_user,firstname_user,lastname_user,gender_user,birthdate_user,email_user,phone_user,image_user:String!
        
        //TOKEN
        if let token = json["token"] as? String{
            worked = true
            saveFBacessToken(access_token: accessToken)
            Global.global.userInfo.token = token
            token_user = token
        }
        else{
            token_user = ""
        }
        
        //USER DATA
        if let data = json["data"] as? [String:Any]{
            
            if let id = data["id"] as? Int{
                idUser = id
            }
            else{
                idUser = 0
            }
            if let first_name = data["first_name"] as? String{
                firstname_user = first_name
            }
            else{
                firstname_user = ""
            }
            if let last_name = data["last_name"] as? String{
                lastname_user = last_name
            }
            else{
                lastname_user = ""
            }
            if let gender = data["gender"] as? String{
                gender_user = gender
            }
            else{
                gender_user = ""
            }
            if let birth_date_info = data["birth_date"] as? [String:Any]{
                if let date = birth_date_info["date"] as? String{
                    birthdate_user = date
                }
                else{
                    birthdate_user = ""
                }
            }
            else{
                birthdate_user = ""
            }
            if let email = data["email"] as? String{
                email_user = email
            }
            else{
                email_user = ""
            }
            if let phone = data["phone"] as? String{
                phone_user = phone
            }
            else{
                phone_user = ""
            }
            if let image = data["profile_image"] as? String{
                image_user = "\(Global.global.ip!)image/\(image)"
            }
            else{
                image_user = ""
            }
            worked = true
            Global.global.userInfo = User(firstname: firstname_user, lastname: lastname_user, email: email_user, sexe: gender_user, birthdate: birthdate_user, phone: phone_user, id: idUser, image_url: image_user, token: token_user, cards: [userCard]())
        }
        return worked
    }
    
    func getTokenWithFB(access_token:String)->Bool{
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)loginfacebook", method: "POST",body:"access_token=\(access_token)")
        
        if let token = json["token"] as? String{
            Global.global.userInfo.token = token
            worked = true
        }
        
        return worked
    }
    
    func saveFBacessToken(access_token:String){
        UserDefaults.standard.set(access_token, forKey: "FB_Token")
    }
    
    func saveToken(token:String){
        UserDefaults.standard.set(token, forKey: "Token")
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
