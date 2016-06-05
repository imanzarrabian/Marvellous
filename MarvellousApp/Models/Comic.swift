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
    var thumbnail = ""
    let description: String

    //computed propertie
    var free: Bool {
        return price == 0.0
    }
    //Constructeur prenant en entrée un Dictionary à écrire
    
    init(dict: [String: AnyObject]) {
        title = dict["title"] as! String
        isbn = dict["isbn"] as! String
        issueNumber = dict["issueNumber"] as! Int
        
        if let desc = dict["description"] as? String {
            description =  desc
        } else {
            description = ""
        }
        
        if let thumbnailDict = dict["thumbnail"] as? [String: AnyObject] {
            let path = thumbnailDict["path"] as! String
            let ext = thumbnailDict["extension"] as! String
            thumbnail = path + "." + ext
        }
        
        if let priceDict = dict["prices"] as? [[String: AnyObject]] {
            if let firstPrice = priceDict.first {
                price = firstPrice["price"] as! Double
            }
        }
    }

}

extension Comic {
    static func getRemoteComics(offset: Int, completionHandler: Response<AnyObject, NSError> -> Void) {
        let apikey = "f1046276a17a9a7bbdbd03bc07c3179f"
        let ts = "thomas"
        let hash = "6d864e617ed17ca154a958947fa125bd"
        
        let params: [String : AnyObject] = ["apikey" : apikey, "ts" : ts, "hash" : hash, "limit" : 20, "offset": offset]
        
        Alamofire.request(.GET, "http://gateway.marvel.com/v1/public/comics", parameters: params).responseJSON { response in completionHandler(response) }
    }
}