//
//  APIRequestProfile.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestProfile{
    
    func modifyEmail(newemail:String,password:String)->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)changeemail", method: "PUT", body: "password=\(password)&email=\(newemail)", needToken: true)
        
        if let _ = json["status"] as? String{
            return true
        }
        else{
            return false
        }
    }
    
    
    func modifyPassword(oldpassword:String,newpassword:String)->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)changeemail", method: "PUT", body: "password=\(newpassword)&newpassword=\(newpassword)", needToken: true)
        
        if let _ = json["status"] as? String{
            return true
        }
        else{
            return false
        }
    }
    
    func modifyUser(first_name:String = "",last_name:String = "")->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)user", method: "PUT", body: "first_name=\(first_name)&last_name=\(last_name)", needToken: true)
        
        if let _ = json["status"] as? String{
            return true
        }
        else{
            return false
        }
    }
    
    func modifyProfileImage(imageID:Int)->String{
        let json = Utility().getJson(url: "\(Global.global.ip!)user", method: "PUT", body: "image_id=\(imageID)", needToken: true)
        
        if let data = json["data"] as? [String:Any]{
            return data["profile_image"] as! String
        }
        else{
            return ""
        }
        
        
    }
}
