//
//  Comic.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 20/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import Foundation

struct Comic {
    
    //title, isbn, issue number, price, image
    let title: String
    let isbn: String
    let issueNumber: Int
    var price = 0.0
    var image = ""

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