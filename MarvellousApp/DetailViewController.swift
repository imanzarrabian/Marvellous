//
//  DetailViewController.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 26/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var comic: Comic!

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayComicInfos()
    }
    
    func displayComicInfos() {
        titleLabel.text = comic.title
        if let desc = comic.description {
            descriptionLabel.text = desc
        }
        else {
            descriptionLabel.text = "no description"
        }
        isbnLabel.text = comic.isbn
        priceLabel.text = comic.free ? "FREE!" : String(comic.price)
        
        if let url = NSURL(string: comic.image),
            let image = UIImage(named: "comicPlaceholder") {
            
            comicImageView.sd_setImageWithURL(url, placeholderImage: image)
        }
    }
}
