//
//  APIRequestCommande.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-10-03.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class APIRequestCommande{
    func getItemTypes()->[ItemType]{
        var arrItemTypes = [ItemType]()
        
        var json = Utility().getJson(url: "\(Global.global.ip!)item/types", method: "GET",needToken:true)
        
        if let data = json["data"] as? [[String:Any]]{
            if(data.count > 0){
                for x in 0...data.count - 1{
                    
                    arrItemTypes.append(ItemType(id: data[x]["id"] as! Int, name: data[x]["name"] as! String, image: data[x]["image"] as! String))
                }
            }
        }
        
        return arrItemTypes
    }
    
    func getItemsList(id:Int)->[ItemList]{
        var itemsList = [ItemList]()
        
        var json = Utility().getJson(url: "\(Global.global.ip!)items?type=\(id)", method: "GET",needToken:true)
        if let data = json["data"] as? [[String:Any]]{
            if(data.count > 0){
                for x in 0...data.count - 1{
                    itemsList.append(ItemList(id: data[x]["id"] as! Int, name: data[x]["name"] as! String, image: data[x]["image"] as! String))
                }
            }
        }
        return itemsList
    }
    
    func getItemInfo(item_id:Int)->Item{
        var item:Item!
        
        var json = Utility().getJson(url: "\(Global.global.ip!)item/\(item_id)", method: "GET",needToken:true)
        
        if let data = json["data"] as? [String:Any]{
        
            //BASIC INFO
            let id = data["id"] as! Int
            let name = data["name"] as! String
            let description = data["description"] as! String
            let type = data["type"] as! String
            let image = data["image"] as! String
            var arrPrices = [PriceItem]()
            var arrSubItems = [Subitem]()
            //Array Price
            
            
            //Getting prices
            let prices = data["prices"] as! [String:Any]
            let dataPrices = prices["data"] as! [[String:Any]]
            if(dataPrices.count > 0){
                for x in 0...dataPrices.count - 1{
                    var size:String = ""
                    if let newSize = dataPrices[x]["size"] as? String{
                        size = newSize
                    }
                    arrPrices.append(PriceItem(id: dataPrices[x]["id"] as! Int, price: dataPrices[x]["price"] as! NSNumber, size: size))
                }
            }
            
            //Gettingg subitems
            let subitems = data["subitems"] as! [String:Any]
            let subitemsData = subitems["data"] as! [[String:Any]]
            if(subitemsData.count > 0){
                for y in 0...subitemsData.count - 1{
                    var price:NSNumber!
                    if let newPrice = subitemsData[y]["price"] as? NSNumber{
                        price = newPrice
                    }
                    else{
                        price = 0
                    }
                    arrSubItems.append(Subitem(id: subitemsData[y]["id"] as! Int, name: subitemsData[y]["name"] as! String, price: price, image: subitemsData[y]["image"] as! String))
                }
            }
            
            item = Item(id: id, description: description, type: type, image: image,name: name, prices: arrPrices, subitems: arrSubItems)
            
        }
        
        return item
    }
    
    
    func order(arrayItems:[itemOrder]){
        let json = Utility().getJson(url: "\(Global.global.ip!)order", method: "POST",body:"",needToken:true)
    }
    
    func buildJsonOrder(arrayItems:[itemOrder])->[String:Any]{
        return ["test":"test"]
    }
}
