//
//  FirstViewController.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 19/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var comicsArray: [Comic]?
    @IBOutlet weak var comicTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Comic.getRemoteComics ({ (response) in
    
            switch response.result {
            case .Success:
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if let dataDict = dict["data"] {
                        
                        if let array = dataDict["results"] as? Array<AnyObject>  {
                            
                            self.comicsArray = array.map
                                { Comic(dict: $0 as! [String: AnyObject]) }
                            
                            self.comicTV.reloadData()
                            
                        }
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
        })
    }
}

extension FirstViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsArray?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ComicCell", forIndexPath: indexPath) as! ComicCell
 
        if let array = comicsArray {
            let comic = array[indexPath.row]
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
        }
        
        //print("row \(indexPath.row)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

