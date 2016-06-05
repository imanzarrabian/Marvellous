//
//  Artist.swift
//  MarvellousApp
//
//  Created by Thomas PARIENTE on 6/5/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import Foundation
import Alamofire

struct Artist {
    
    let fullName: String
    var thumbnail = ""
    
    init(dict: [String: AnyObject]) {
        fullName = dict["fullName"] as! String
        if let thumbnailDict = dict["thumbnail"] as? [String: AnyObject] {
            let path = thumbnailDict["path"] as! String
            let ext = thumbnailDict["extension"] as! String
            thumbnail = path + "." + ext
        }
    }
}

extension Artist {
    static func getRemoteArtists(offset: Int, completionHandler: Response<AnyObject, NSError> -> Void) {
        let apikey = "f1046276a17a9a7bbdbd03bc07c3179f"
        let ts = "thomas"
        let hash = "6d864e617ed17ca154a958947fa125bd"
        
        let params: [String : AnyObject] = ["apikey" : apikey, "ts" : ts, "hash" : hash, "limit" : 20, "offset": offset]
        
        Alamofire.request(.GET, "http://gateway.marvel.com/v1/public/creators", parameters: params).responseJSON { response in completionHandler(response) }
    }
}