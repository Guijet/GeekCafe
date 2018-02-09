//
//  Branch.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-13.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import CoreLocation

struct Branch{

    init(id:Int,coordinates:CLLocationCoordinate2D,location:String){
        self.id = id
        self.coordinates = coordinates
        self.location = location
    }
    var id:Int
    var coordinates:CLLocationCoordinate2D!
    var location:String
    
}
