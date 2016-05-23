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
    //Constructeur prenant en entrée un Dictionary à écrire

}