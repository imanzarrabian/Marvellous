//
//  Comic.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 20/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import Foundation
import Alamofire

struct Creator {
    
    //id, firstName, middleName, lastName, thumbnail
    let id: Int
    let firstName: String
    let middleName: String
    let lastName: String
    var thumbnail = ""
    
    //computed property
    var fullName: String {
        return firstName + middleName + lastName
    }
    
    //Constructeur prenant en entrée un Dictionary
    //EXERCICE : UTILISER SWIFTYJSON
    init(dict: Dictionary<String, AnyObject>) {
        
        //Les infos de base
        id = dict["id"] as! Int
        firstName = dict["firstName"] as! String
        middleName = dict["middleName"] as! String
        lastName = dict["lastName"] as! String
        
        //L'image
        if let imageDict = dict["thumbnail"] as? [String: AnyObject] {
            let path = imageDict["path"] as! String
            let ext = imageDict["extension"] as! String
            thumbnail =  path + "." + ext
        }
    }
}

//MARK: Remote functions
extension Creator {
    static func getRemoteCreators(offset: Int,       completionHandler: Response<AnyObject, NSError> -> Void
        ) {
        let apiKey = "c3901f9b2fb11e2322853b3ede27f438"
        let ts = "testtest"
        let hash = "1d312b3f93ad2dbbd2ab9af0a125b73a"
        
        let param: [String : AnyObject] = ["apikey" : apiKey, "hash" : hash, "ts" : ts, "offset" : offset]
        
        Alamofire.request(.GET, "http://gateway.marvel.com/v1/public/creators", parameters: param).responseJSON { response in
            
            //map [JSON] -> [Creator]
            //crée un nouveau Result<[Creator], Error>
            
            completionHandler(response)
        }
    }
}