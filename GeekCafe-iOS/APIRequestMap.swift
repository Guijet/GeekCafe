//
//  APIRequestMap.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-13.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import CoreLocation

class APIRequestMap{
    func getLocations()->[Branch]{
        var branches = [Branch]()
        let json = Utility().getJson(url: "\(Global.global.ip!)branches", method: "GET",needToken: true)
        
        if let data = json["data"] as? [[String:Any]]{
            if(data.count > 0){
                for x in data{
                    //ID
                    var id:Int!
                    if let idN = x["id"] as? Int{
                        id = idN
                    }
                    if let idS = x["id"] as? String{
                        id = Int(idS)
                    }
                    var location:String!
                    if let locationS = x["location"] as? String{
                        location = locationS
                    }
                    else{
                        location = "Location introuvable."
                    }
                    
                    var coords:String!
                    if let coordsS = x["coordinates"] as? String{
                        coords = coordsS
                    }
                    else{
                        coords = "0,0"
                    }
                    let a = Branch(id: id, coordinates: CLLocationCoordinate2D(latitude: CLLocationDegrees(getLatFromCoords(coords: coords)), longitude: CLLocationDegrees(getLongFromCoords(coords: coords))), location: location)
                    branches.append(a)
                }
            }
        }
        return branches
    }
    
    func getLatFromCoords(coords:String)->Float{
        return coords.components(separatedBy: ",")[0].floatValue
    }
    
    func getLongFromCoords(coords:String)->Float{
        return coords.components(separatedBy: ",")[0].floatValue
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
