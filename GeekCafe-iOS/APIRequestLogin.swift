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
        print(json)
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
        var image_url:String!
        if let user = json["data"] as? [String:Any]{
            
            var id:Int!
            if let idN = user["id"] as? Int{
                id = idN
            }
            if let idS = user["id"] as? Int{
                id = idS
            }
            var first_name:String!
            if let first_nameS = user["first_name"] as? String{
                first_name = first_nameS
            }
            else{
                first_name = "unknown"
            }
            var last_name:String!
            if let last_nameS = user["last_name"] as? String{
                last_name = last_nameS
            }
            else{
                last_name = "unknown"
            }
            var gender:String!
            if let genderS = user["gender"] as? String{
                gender = genderS
            }
            else{
                gender = "unknown"
            }
            var email:String!
            if let emailS = user["email"] as? String{
                email = emailS
            }
            else{
                email = "unknown"
            }
            var phoneUser:String!
            if let phone = user["phone"] as? String{
                phoneUser = phone
            }
            else{
                phoneUser = ""
            }
            var birth_date:String!
            if let birth_dateS = user["birth_date"] as? String{
                birth_date = birth_dateS
            }
            else{
                birth_date = "unknown"
            }
            var image_id:String!
            if let image_idS = user["profile_image"] as? String{
                image_id = image_idS
            }
            else{
                image_id = ""
            }
            image_url = image_id
            let token = Global.global.userInfo.token
            
            var points:Int!
            if let point = user["points"] as? NSNumber{
                points = point.intValue
            }
            else if let pointS = user["points"] as? String{
                if pointS.range(of: ".") != nil {
                    let i = Int(pointS.components(separatedBy: ".").first!)
                    points = i
                }
                else{
                    points = Int(pointS)
                }
            }
            else{
                points = 0
            }
            
            var idAbonnement:Int!
            var points_rewards:NSNumber!
            var discount:NSNumber!
            var price:NSNumber!
            var title:String!
            var description:String!
            var perk:String!
            if let abonnement = user["subscription"] as? [String:Any]{
                if let perkS = abonnement["perk"] as? String{
                    perk = perkS
                }
                else{
                    perk = "Unknown"
                }
                if let descriptionS = abonnement["description"] as? String{
                    description = descriptionS
                }
                else{
                    description = "Unknown"
                }
                if let titleS = abonnement["title"] as? String{
                    title = titleS
                }
                else{
                    title = "unknown"
                }
                
                if let rewards = abonnement["point_reward"] as? NSNumber{
                    points_rewards = rewards
                }
                if let rewardsS = abonnement["point_reward"] as? String{
                    points_rewards = NumberFormatter().number(from: rewardsS)
                }
                
                
                if let discountN = abonnement["discount"] as? NSNumber{
                    discount = discountN
                }
                if let discountS = abonnement["discount"] as? String{
                    discount = NumberFormatter().number(from: discountS)
                }
                
                
                if let priceN = abonnement["price"] as? NSNumber{
                    price = priceN
                }
                if let priceS = abonnement["price"] as? String{
                    price = NumberFormatter().number(from: priceS)
                }
                
                
                if let idN = abonnement["id"] as? Int{
                    idAbonnement = idN
                }
                if let idS = abonnement["id"] as? String{
                    idAbonnement = Int(idS)
                }
                Global.global.userInfo = User(firstname: first_name, lastname: last_name, email: email, sexe: gender, birthdate: birth_date, phone: phoneUser, id: id, image_url: image_url, token: token, abonnement: Abonnement(id:idAbonnement,title:title,description:description,perk:perk,point_reward:points_rewards,discount:discount,price:price),points: points, cards: [userCard]())
                
            }
            worked = true
        }

        return worked
    }
    
    func createAcount(first_name:String,last_name:String,gender:String,birth_date:String,phone:String,email:String,password:String)->Bool{
        
        var worked:Bool = false
        var json = Utility().getJson(url: "\(Global.global.ip!)user", method: "POST",body: "first_name=\(first_name)&last_name=\(last_name)&gender=\(getGenderForRequest(gender:gender))&birth_date=\(birth_date)&phone=\(phone)&email=\(email)&password=\(password)")

        if let token = json["token"] as? String{
            saveToken(token: token)
            if let data = json["data"] as? [String:Any]{
                var id:Int!
                if let idN = data["id"] as? Int{
                    id = idN
                }
                else if let idS = data["id"] as? String{
                    id = Int(idS)
                }
                
                var image_url:String!
                if let image_urlS = data["profile_image"] as? String{
                    image_url = image_urlS
                }
                else{
                    image_url = "unknown"
                }
                var points:Int!
                if let point = data["points"] as? NSNumber{
                    points = point.intValue
                }
                else if let pointS = data["points"] as? String{
                    if pointS.range(of: ".") != nil {
                        let i = Int(pointS.components(separatedBy: ".").first!)
                        points = i
                    }
                    else{
                        points = Int(pointS)
                    }
                }
                else{
                    points = 0
                }
                var idAbonnement:Int!
                var points_rewards:NSNumber!
                var discount:NSNumber!
                var price:NSNumber!
                var title:String!
                var description:String!
                var perk:String!
                if let abonnement = data["subscription"] as? [String:Any]{
                    if let perkS = abonnement["perk"] as? String{
                        perk = perkS
                    }
                    else{
                        perk = "Unknown"
                    }
                    if let descriptionS = abonnement["description"] as? String{
                        description = descriptionS
                    }
                    else{
                        description = "Unknown"
                    }
                    if let titleS = abonnement["title"] as? String{
                        title = titleS
                    }
                    else{
                        title = "unknown"
                    }
                    
                    if let rewards = abonnement["point_reward"] as? NSNumber{
                        points_rewards = rewards
                    }
                    if let rewardsS = abonnement["point_reward"] as? String{
                        points_rewards = NumberFormatter().number(from: rewardsS)
                    }
                    
                    
                    if let discountN = abonnement["discount"] as? NSNumber{
                        discount = discountN
                    }
                    if let discountS = abonnement["discount"] as? String{
                        discount = NumberFormatter().number(from: discountS)
                    }
                    
                    
                    if let priceN = abonnement["price"] as? NSNumber{
                        price = priceN
                    }
                    if let priceS = abonnement["price"] as? String{
                        price = NumberFormatter().number(from: priceS)
                    }
                    
                    
                    if let idN = abonnement["id"] as? Int{
                        idAbonnement = idN
                    }
                    if let idS = abonnement["id"] as? String{
                        idAbonnement = Int(idS)
                    }
                }
                Global.global.userInfo = User(firstname: first_name, lastname: last_name, email: email, sexe: gender, birthdate: birth_date, phone: phone, id: id, image_url: image_url, token: token, abonnement: Abonnement(id:idAbonnement,title:title,description:description,perk:perk,point_reward:points_rewards,discount:discount,price:price),points: points,cards:[userCard]())
            }
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
                    var last4:String!
                    if let last4S = cards[x]["last4"] as? String{
                        last4 = last4S
                    }
                    else{
                        last4 = ""
                    }
                    var expMonth:Int!
                    if let expMonthN = cards[x]["exp_month"] as? Int{
                        expMonth = expMonthN
                    }
                    else{
                        expMonth = 0
                    }
                    var expYear:Int!
                    if let expYearN = cards[x]["exp_year"] as? Int{
                        expYear = expYearN
                    }
                    else{
                        expYear = 0
                    }
                    var brand:String!
                    if let brandS = cards[x]["brand"] as? String{
                        brand = brandS
                    }
                    else{
                        brand = "Unknown"
                    }
                    var idCard:String!
                    if let idCardS = cards[x]["id"] as? String{
                        idCard = idCardS
                    }
                    else{
                        idCard = ""
                    }
                    let a = userCard(last4: last4, expMonth: String(expMonth), expYear: String(expYear), brand: brand, name: cardHolderName, id_card: idCard)
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
                image_user = image
            }
            else{
                image_user = ""
            }
            
            var points:Int!
            if let point = data["points"] as? NSNumber{
                points = point.intValue
            }
            else if let pointS = data["points"] as? String{
                if pointS.range(of: ".") != nil {
                    let i = Int(pointS.components(separatedBy: ".").first!)
                    points = i
                }
                else{
                    points = Int(pointS)
                }
            }
            else{
                points = 0
            }
            var idAbonnement:Int!
            var points_rewards:NSNumber!
            var discount:NSNumber!
            var price:NSNumber!
            var title:String!
            var description:String!
            var perk:String!
            if let abonnement = data["subscription"] as? [String:Any]{
                if let perkS = abonnement["perk"] as? String{
                    perk = perkS
                }
                else{
                    perk = "Unknown"
                }
                if let descriptionS = abonnement["description"] as? String{
                    description = descriptionS
                }
                else{
                    description = "Unknown"
                }
                if let titleS = abonnement["title"] as? String{
                    title = titleS
                }
                else{
                    title = "unknown"
                }
                
                if let rewards = abonnement["point_reward"] as? NSNumber{
                    points_rewards = rewards
                }
                if let rewardsS = abonnement["point_reward"] as? String{
                    points_rewards = NumberFormatter().number(from: rewardsS)
                }
                
                
                if let discountN = abonnement["discount"] as? NSNumber{
                    discount = discountN
                }
                if let discountS = abonnement["discount"] as? String{
                    discount = NumberFormatter().number(from: discountS)
                }
                
                
                if let priceN = abonnement["price"] as? NSNumber{
                    price = priceN
                }
                if let priceS = abonnement["price"] as? String{
                    price = NumberFormatter().number(from: priceS)
                }
                
                
                if let idN = abonnement["id"] as? Int{
                    idAbonnement = idN
                }
                if let idS = abonnement["id"] as? String{
                    idAbonnement = Int(idS)
                }
            }
            
            worked = true
            Global.global.userInfo = User(firstname: firstname_user, lastname: lastname_user, email: email_user, sexe: gender_user, birthdate: birthdate_user, phone: phone_user, id: idUser, image_url: image_user, token: token_user, abonnement: Abonnement(id:idAbonnement,title:title,description:description,perk:perk,point_reward:points_rewards,discount:discount,price:price),points:points, cards: [userCard]())
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
