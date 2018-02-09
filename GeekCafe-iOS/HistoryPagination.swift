//
//  HistoryPagination.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-21.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

struct MetaPagination{
    init(nextString:String,isNext:Bool){
        self.isNext = isNext
        self.nextString = nextString
    }
    var nextString:String
    var isNext:Bool
}
