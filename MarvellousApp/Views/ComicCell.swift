//
//  ComicCell.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 23/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

    //title, issueNumber, price (avec macaron free), image
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var comicIV: UIImageView!
}
