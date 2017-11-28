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
                    var id:Int!
                    if let idN = data[x]["id"] as? Int{
                        id = idN
                    }
                    if let idS = data[x]["id"] as? String{
                        id = Int(idS)
                    }
                    var name:String!
                    if let nameS = data[x]["name"] as? String{
                        name = nameS
                    }
                    else{
                        name = "#unknown"
                    }
                    
                    var image:String!
                    if let imageS = data[x]["image"] as? String{
                        image = imageS
                    }
                    else{
                        image = ""
                    }
                    arrItemTypes.append(ItemType(id: id, name: name, image: image))
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
                    var id:Int!
                    if let idN = data[x]["id"] as? Int{
                        id = idN
                    }
                    if let idS = data[x]["id"] as? String{
                        id = Int(idS)
                    }
                    var name:String!
                    if let nameS = data[x]["name"] as? String{
                        name = nameS
                    }
                    else{
                        name = "#unknown"
                    }
                    var image:String!
                    if let imageS = data[x]["image"] as? String{
                        image = imageS
                    }
                    else{
                        image = ""
                    }
                    itemsList.append(ItemList(id: id, name: name, image: image))
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
            var id:Int!
            if let idN = data["id"] as? Int{
                id = idN
            }
            if let idS = data["id"] as? String{
                id = Int(idS)
            }
            var name:String!
            if let nameS = data["name"] as? String{
                name = nameS
            }
            else{
                name = "#unknown"
            }
            var description:String!
            if let descriptionS = data["description"] as? String{
                description = descriptionS
            }
            else{
                description = "Unable to load description"
            }
            var type:String!
            if let typeS = data["type"] as? String{
                type = typeS
            }
            else{
                type = "Unable to load type"
            }
            var image:String!
            if let imageS = data["image"] as? String{
                image = imageS
            }
            else{
                image = ""
            }
            
            //Array Price
            var arrPrices = [PriceItem]()
            var arrSubItems = [Subitem]()
            //Getting prices
            if let prices = data["prices"] as? [String:Any]{
                if let dataPrices = prices["data"] as? [[String:Any]]{
                    if(dataPrices.count > 0){
                        for x in 0...dataPrices.count - 1{
                            var size:String = ""
                            if let newSize = dataPrices[x]["size"] as? String{
                                size = newSize
                            }
                            var idPrice:Int!
                            if let idPriceN = dataPrices[x]["id"] as? Int{
                                idPrice = idPriceN
                            }
                            if let idPriceS = dataPrices[x]["id"] as? String{
                                idPrice = Int(idPriceS)
                            }
                            var price:NSNumber!
                            if let priceN = dataPrices[x]["price"] as? NSNumber{
                                price = priceN
                            }
                            if let priceS = dataPrices[x]["price"] as? String{
                                price = NumberFormatter().number(from:priceS)
                            }
                            
                            arrPrices.append(PriceItem(id: idPrice, price: price, size: size))
                        }
                    }
                }
            }
            
            
            
            //Gettingg subitems
            if let subitems = data["subitems"] as? [String:Any]{
                if let subitemsData = subitems["data"] as? [[String:Any]]{
                    if(subitemsData.count > 0){
                        for y in 0...subitemsData.count - 1{
                            var price:NSNumber!
                            if let newPrice = subitemsData[y]["price"] as? NSNumber{
                                price = newPrice
                            }
                            else if let newPrice = subitemsData[y]["price"] as? String{
                                price = NumberFormatter().number(from: newPrice)
                            }
                            else{
                                price = 0
                            }
                            var idSubItem:Int!
                            if let idSubitemsN = subitemsData[y]["id"] as? Int{
                                idSubItem = idSubitemsN
                            }
                            if let idSubitemsS = subitemsData[y]["id"] as? String{
                                idSubItem = Int(idSubitemsS)
                            }
                            var name:String!
                            if let nameS = subitemsData[y]["name"] as? String{
                                name = nameS
                            }
                            else{
                                name = "unknown name"
                            }
                            var image:String!
                            if let imageS = subitemsData[y]["image"] as? String{
                                image = imageS
                            }
                            else{
                                image = ""
                            }
                            var isTopping:Bool!
                            if let isToppingB = subitemsData[y]["is_topping"] as? Bool{
                                isTopping = isToppingB
                            }
                            else{
                                isTopping = false
                            }
                            arrSubItems.append(Subitem(id: idSubItem, name: name, price: price, image: image, isTopping: isTopping))
                        }
                    }
                }
            }
            
            
            
            item = Item(id: id, description: description, type: type, image: image,name: name, prices: arrPrices, subitems: arrSubItems)
            
        }
        
        return item
    }
    
    
    //
    //
    //GET JSON DATE WITH DICTIONNARY OF ORDER
    //
    //
    func buildJsonOrder(arrayItems:[itemOrder],card_pay:Bool,branch_id:Int,counter_id:Int,points:Int)->Data{
        
        var items = [[String:Any]]()
        if(arrayItems.count > 0){
            for x in arrayItems{
                var arrSub = [[String:Any]]()
                if(x.subItemIds.count > 0){
                    for y in x.subItemIds{
                        arrSub.append(["id":y.intValue])
                    }
                }
                if(x.toppingId != 0){
                    arrSub.append(["id":x.toppingId])
                }
                let a = ["price_id":x.price_id,"subitems":arrSub] as [String : Any]
                items.append(a)
            }
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["points":points,"card_pay":card_pay,"branch_id":branch_id,"counter_id":counter_id,"items":items] as [String : Any], options: .prettyPrinted)
        return jsonData!
    }
    
    
    //
    //
    //ORDER
    //
    //
    func getOrderResult(arrayItems:[itemOrder],card_pay:Bool,branch_id:Int,counter_id:Int,points:Int)->[String:Any]{
        
        var finish = false
        var result: [String: Any]!
        
        DispatchQueue.global(qos:.background).async {
            var request = URLRequest(url: URL(string: "\(Global.global.ip!)order")!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(Global.global.userInfo.token)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = self.buildJsonOrder(arrayItems: arrayItems,card_pay: card_pay,branch_id: branch_id, counter_id: counter_id, points: points)
        
            
            let config = URLSessionConfiguration.default
            config.httpMaximumConnectionsPerHost = 100
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                let string1 = String(data: data!, encoding: String.Encoding.utf8)
                print(string1!)
                
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    finish = true
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, buxt is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    result = ["nil":"nil"]
                }
                do
                {
                    
                    if let parsedData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                        result = parsedData
                    } else {
                        result = ["nil":"nil"]
                    }
                    
                    finish = true
                }
                catch let error as NSError
                {
                    print(error)
                    result = ["nil":"nil"]
                    finish = true
                }
            }
            task.resume()
            session.finishTasksAndInvalidate()
            
        }
        while(!finish) { usleep(300) }
        return result
    }
    
    func order(arrayItems:[itemOrder],card_pay:Bool,branch_id:Int,counter_id:Int,points:Int)->Bool{
        var worked:Bool = false
        
        let result = getOrderResult(arrayItems: arrayItems, card_pay: card_pay, branch_id: branch_id, counter_id: counter_id, points: points)
        if let _ = result["status"] as? String{
            worked = true
        }
        return worked
    }
    
   
}
