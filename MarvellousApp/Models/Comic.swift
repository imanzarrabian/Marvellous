//
//  Comic.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 20/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import Foundation
import Alamofire

struct Comic {
    
    //title, isbn, issue number, price, image
    let title: String
    let isbn: String
    let issueNumber: Int
    var price = 0.0
    var image = ""
    var description: String?

    //computed propertie
    var free: Bool {
        return price == 0.0
    }
    
    //Constructeur prenant en entrée un Dictionary
    //EXERCICE : UTILISER SWIFTYJSON
    init(dict: Dictionary<String, AnyObject>) {
        
        //Les infos de base
        title = dict["title"] as! String
        isbn = dict["isbn"] as! String
        issueNumber = dict["issueNumber"] as! Int
        description = dict["description"] as? String
        
        //L'image
        if let imageDict = dict["thumbnail"] as? [String: AnyObject] {
            let path = imageDict["path"] as! String
            let ext = imageDict["extension"] as! String
            image =  path + "." + ext
        }
        
        //Le prix
        if let priceDict = dict["prices"] as? [[String: AnyObject]] {
            if let firstPrice = priceDict.first {
                price = firstPrice["price"] as! Double
            }
        }
    }
}

//MARK: Remote functions
extension Comic {
    static func getRemoteComics(offset: Int, completionHandler: Response<AnyObject, NSError> -> Void) {
        let apiKey = "c3901f9b2fb11e2322853b3ede27f438"
        let ts = "testtest"
        let hash = "1d312b3f93ad2dbbd2ab9af0a125b73a"
        
        let param: [String : AnyObject] = ["apikey" : apiKey, "hash" : hash, "ts" : ts, "offset" : offset]
        
        Alamofire.request(.GET, "http://gateway.marvel.com/v1/public/comics", parameters: param).responseJSON { response in
            
            completionHandler(response)            
        }
    }
    
    
}