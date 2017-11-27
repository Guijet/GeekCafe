//
//  APIRequestPaiement.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-25.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestPaiement{
    
    func deleteCard(card_token:String)->Bool{

        let json = Utility().getJson(url: "\(Global.global.ip!)user/payment", method: "DELETE",body: "card_token=\(card_token)",needToken: true)
        if let _ = json["status"] as? String{
            return true
        }
        else{
            return false
        }
    }
}
