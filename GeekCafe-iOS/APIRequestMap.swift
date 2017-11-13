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
                    branches.append(Branch(id: x["id"] as! Int, coordinates: CLLocationCoordinate2D(latitude: CLLocationDegrees(getLatFromCoords(coords: x["coordinates"] as! String)), longitude: CLLocationDegrees(getLongFromCoords(coords: x["coordinates"] as! String))), location: x["location"] as! String))
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
