//
//  Subitem.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct Subitem{
    init(id:Int,image:UIImage,name:String){
        self.id = id
        self.image = image
        self.name = name
    }
    var id:Int
    var image:UIImage
    var name:String
}
