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
    
    
    //
    //
    //GET JSON DATE WITH DICTIONNARY OF ORDER
    //
    //
    func buildJsonOrder(arrayItems:[itemOrder],card_pay:Bool,branch_id:Int)->Data{
        
        var items = [[String:Any]]()
        if(arrayItems.count > 0){
            for x in arrayItems{
                var arrSub = [[String:Any]]()
                if(x.subItemIds.count > 0){
                    for y in x.subItemIds{
                        arrSub.append(["id":y.intValue])
                    }
                }

                let a = ["price_id":x.price_id,"subitems":arrSub] as [String : Any]
                items.append(a)
            }
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["card_pay":card_pay,"branch_id":branch_id,"items":items] as [String : Any], options: .prettyPrinted)
        return jsonData!
    }
    
    
    //
    //
    //ORDER
    //
    //
    func getOrderResult(arrayItems:[itemOrder],card_pay:Bool,branch_id:Int)->[String:Any]{
        
        var finish = false
        var result: [String: Any]!
        
        DispatchQueue.global(qos:.background).async {
            var request = URLRequest(url: URL(string: "\(Global.global.ip!)order")!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(Global.global.userInfo.token)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = self.buildJsonOrder(arrayItems: arrayItems,card_pay: card_pay,branch_id: branch_id)
        
            
            let config = URLSessionConfiguration.default
            config.httpMaximumConnectionsPerHost = 100
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request) { data, response, error in
                
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
    
    func order(arrayItems:[itemOrder],card_pay:Bool,branch_id:Int)->Bool{
        var worked:Bool = false
        
        let result = getOrderResult(arrayItems: arrayItems, card_pay: card_pay, branch_id: branch_id)
        if let _ = result["status"] as? String{
            worked = true
        }
        return worked
    }
    
   
}
