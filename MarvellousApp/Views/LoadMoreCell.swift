//
//  LoadMoreCell.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 26/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class LoadMoreCell: UITableViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(startOrStopSpinner), name: "spinner_notif", object: nil)
    }
    
    func startOrStopSpinner() {
        if spinner.isAnimating() {
            spinner.stopAnimating()
        }
        else {
            spinner.startAnimating()
            spinner.hidden = false
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
