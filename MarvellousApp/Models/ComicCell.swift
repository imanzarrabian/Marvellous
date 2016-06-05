//
//  ComicCell.swift
//  MarvellousApp
//
//  Created by Thomas PARIENTE on 5/24/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {
    @IBOutlet weak var comicPic: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var isbn: UILabel!
    @IBOutlet weak var comicDesc: UILabel!
}
