//
//  Prices.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-08.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class Prices{
    //WITH PRICE ARRAYS
    func getTotalBeforeTaxes(arrayPrices:[NSNumber])->NSNumber{
        var totalPrice:Float = 0
        for x in arrayPrices{
            totalPrice += x.floatValue
        }
        return totalPrice as NSNumber
    }
    
    func getTaxes(price:Float)->NSNumber{
        return price * 0.1475 as NSNumber
    }
    
    
    
    func getTaxesWIthPrice(price:Float,saved:Float)->Float{
        let total:Float = price - saved
        print(total)
        return total * 0.1475
    }
    
    func getTotalWithTaxes(subTotal:Float,taxes:Float,saved:Float)->Float{
        let total = subTotal - saved
        return total + taxes
    }
}
