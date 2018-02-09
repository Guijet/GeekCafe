//
//  APIRequestProfile.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-05.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestProfile{
    //WORKING
    func modifyEmail(newemail:String,password:String)->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)user/changeemail", method: "PUT", body: "password=\(password)&email=\(newemail)", needToken: true)
        
        if let status = json["status"] as? String{
            if(status == "Email changed successfully!"){
                Global.global.userInfo.email = newemail
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }
    
    //WORKING
    func modifyPassword(oldpassword:String,newpassword:String)->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)user/changepassword", method: "PUT", body: "password=\(oldpassword)&newpassword=\(newpassword)", needToken: true)
        
        if let status = json["status"] as? String{
            if(status == "Password changed successfully!"){
                return true
            }
            else{
                return false
            }
            
        }
        else{
            return false
        }
    }
    
    
    func modifyUser(first_name:String = "",last_name:String = "",phone:String="")->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)user", method: "PUT", body: "first_name=\(first_name)&last_name=\(last_name)&phone=\(phone)", needToken: true)
        
        if let data = json["data"] as? [String:Any]{
            Global.global.userInfo.lastname = data["last_name"] as! String
            Global.global.userInfo.firstname = data["first_name"] as! String
            Global.global.userInfo.phone = data["phone"] as! String
            return true
        }
        else{
            return false
        }
    }
    
    func modifyProfileImage(imageID:String)->Bool{
        let json = Utility().getJson(url: "\(Global.global.ip!)user", method: "PUT", body: "image_id=\(imageID)", needToken: true)
        
        if let data = json["data"] as? [String:Any]{
            Global.global.userInfo.image_url = data["profile_image"] as! String
            return true
        }
        else{
            return false
        }
    }
    
    func uploadProfileImage(base64:String)->Bool{
        var isUploaded:Bool = false
        var finish = false
        var base64 = base64
        DispatchQueue.global(qos:.background).async {
            var request = URLRequest(url: URL(string: "\(Global.global.ip!)upload")!)
            request.httpMethod = "POST"
            
            request.addValue("Bearer \(Global.global.userInfo.token)", forHTTPHeaderField: "Authorization")
            base64 = base64.replacingOccurrences(of: "+", with: "%2B")
            base64 = base64.replacingOccurrences(of: "/", with: "%2F")
            base64 = base64.replacingOccurrences(of: "=", with: "%3D")
            
            let postString = "image=\(base64)"
            request.httpBody = postString.data(using: .utf8)
            let config = URLSessionConfiguration.default
            config.httpMaximumConnectionsPerHost = 10
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    finish = true
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    finish = true
                }
                do
                {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                    if let success = parsedData["success"] as? Int{
                        if success == 1{
                          
                            if(self.modifyProfileImage(imageID: parsedData["image_id"] as! String))
                            {
                                isUploaded = true
                            }
                            
                        }
                    }
                    finish = true
                }
                catch let error as NSError
                {
                    finish = true
                    print(error)
                }
            }
            task.resume()
            session.finishTasksAndInvalidate()
            
        }
        while(!finish) { usleep(300) }
        return isUploaded
    }
    
    func imageToBase64(image:UIImage)->String{
        let myImage = UIImageJPEGRepresentation(image.resizeImageWith(newSize: CGSize(width: 400, height: 400)),0)!
        let strBase64 = myImage.base64EncodedString(options: .init(rawValue: 0))
        return strBase64
    }
}

extension UIImage{
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
}
