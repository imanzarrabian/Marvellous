//
//  FirstViewController.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 19/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class ComicsViewController: UIViewController {

    enum MarvelDataType {
        case Comics, Creators
    }
    
    var dataType = MarvelDataType.Comics {
        didSet {
            if dataOffset == 0 {
                displayItems(dataType)
            }
        }
    }
    
    var comicsArray: [Comic] = []
    var creatorsArray: [Creator] = []

    //computed properties
    var dataOffset: Int {
        return dataType == .Comics ? comicsArray.count : creatorsArray.count
    }
    
    @IBOutlet weak var comicTV: UITableView!
    
    @IBAction func valueChanged(sender: UISegmentedControl) {
        dataType = sender.selectedSegmentIndex == 0 ? .Comics : .Creators
        
        comicTV.reloadData()
        let indexPathTop = NSIndexPath(forRow: 0, inSection: 0)
        comicTV.scrollToRowAtIndexPath(indexPathTop, atScrollPosition: .Top, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicTV.estimatedRowHeight = 200.0
        comicTV.rowHeight = UITableViewAutomaticDimension
        
        displayItems(dataType)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let cell = sender as? ComicCell,
            let indexPath = comicTV.indexPathForCell(cell),
            let vc = segue.destinationViewController as? DetailViewController else {
                return
        }
        
        let comic = comicsArray[indexPath.row]
        print("comic \(comic.title)")
        vc.comic = comic
        
    }
    
    func displayItems(type: MarvelDataType) {
        //declencher un WS
        //START SPINNER
        NSNotificationCenter.defaultCenter().postNotificationName("spinner_notif", object: nil)
        
        //Fetch Queries depuis Realm + display
        
        switch type {
        case .Comics:
            Comic.getRemoteComics(dataOffset) { (response) in
                
                switch response.result {
                case .Success:
                    if let dict = response.result.value as? [String : AnyObject] {
                        if let dataDict = dict["data"] {
                            
                            if let array = dataDict["results"] as? Array<AnyObject>  {
                                
                                self.comicsArray += array.map
                                    { Comic(dict: $0 as! [String: AnyObject]) }
                                
                                self.comicTV.reloadData()
                                //STOP SPINNER
                                NSNotificationCenter.defaultCenter().postNotificationName("spinner_notif", object: nil)
                            }
                        }
                    }
                    
                case .Failure(let error):
                    print(error)
                }
            }
        case .Creators:
            Creator.getRemoteCreators(dataOffset) { (response) in
                
                switch response.result {
                case .Success:
                    if let dict = response.result.value as? [String : AnyObject] {
                        if let dataDict = dict["data"] {
                            
                            if let array = dataDict["results"] as? Array<AnyObject>  {
                                
                                self.creatorsArray += array.map
                                    { Creator(dict: $0 as! [String: AnyObject]) }
                                
                                self.comicTV.reloadData()
                                //STOP SPINNER
                                NSNotificationCenter.defaultCenter().postNotificationName("spinner_notif", object: nil)
                            }
                        }
                    }
                    
                case .Failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension ComicsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataType == .Comics ? comicsArray.count + 1 : creatorsArray.count + 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        
        switch dataType {
        case .Comics:
            if indexPath.row == comicsArray.count {
                let cell = tableView.dequeueReusableCellWithIdentifier("LoadMoreCell", forIndexPath: indexPath)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("ComicCell", forIndexPath: indexPath) as! ComicCell
                
                let comic = comicsArray[indexPath.row]
                cell.titleLabel.text = comic.title
                if let desc = comic.description {
                    cell.descriptionLabel.text = desc
                }
                else {
                    cell.descriptionLabel.text = "no description"
                }
                cell.isbnLabel.text = comic.isbn
                
                
                cell.priceLabel.text = comic.free ? "FREE!" : String(comic.price)
                
                if let url = NSURL(string: comic.image),
                    let image = UIImage(named: "comicPlaceholder") {
                    
                    cell.comicIV.sd_setImageWithURL(url, placeholderImage: image)
                }
                
                //print("row \(indexPath.row)")
                return cell
            }

            
        case .Creators:
            if indexPath.row == creatorsArray.count {
                let cell = tableView.dequeueReusableCellWithIdentifier("LoadMoreCell", forIndexPath: indexPath)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("CreatorCell", forIndexPath: indexPath) as! CreatorCell
                
                let creator = creatorsArray[indexPath.row]
                cell.nameLabel.text = creator.fullName
                
                if let url = NSURL(string: creator.thumbnail),
                    let image = UIImage(named: "comicPlaceholder") {
                    
                    cell.creatorIV.sd_setImageWithURL(url, placeholderImage: image)
                }

                return cell
            }
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch dataType {
        case .Comics:
            if indexPath.row == comicsArray.count {
                displayItems(dataType)
            }
        case .Creators:
            if indexPath.row == creatorsArray.count {
                displayItems(dataType)
            }
        }
    }
}

