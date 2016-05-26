//
//  FirstViewController.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 19/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class ComicsViewController: UIViewController {

    var comicsArray: [Comic] = []
    //computed properties
    var comicsOffset: Int {
        return comicsArray.count
    }
    
    @IBOutlet weak var comicTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicTV.estimatedRowHeight = 200.0
        comicTV.rowHeight = UITableViewAutomaticDimension
        
        displayComics()
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
    
    func displayComics() {
        //declencher un WS
        //START SPINNER
        NSNotificationCenter.defaultCenter().postNotificationName("spinner_notif", object: nil)
        
        Comic.getRemoteComics(comicsOffset) { (response) in
            
            switch response.result {
            case .Success:
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
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
    }
}

extension ComicsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsArray.count + 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == comicsArray.count {
            displayComics()
        }
    }
    
    
    
}

