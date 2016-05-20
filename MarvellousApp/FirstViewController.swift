//
//  FirstViewController.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 19/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if appDelegate.json["results"] != nil  {
            let array = appDelegate.json["results"] as! Array<AnyObject>
           
            print(array)
            //MAP + CAST
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

