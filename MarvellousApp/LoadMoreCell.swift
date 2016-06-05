//
//  LoadMoreCell.swift
//  MarvellousApp
//
//  Created by Thomas PARIENTE on 5/26/16.
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
            
        }
    }
}

