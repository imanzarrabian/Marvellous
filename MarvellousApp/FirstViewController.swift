//
//  FirstViewController.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 19/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    var comicsArray: [Comic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //On accede à l'instance de l'AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //on unwrapp le contenu de appDelegate.json["results"] qui est optionnel car le champs "results" peut ne pas exister
        //on cast par la même occasion ce contenu en un objet Array<AnyObject>
        //le resultat de l'expression à droite du signe égal est un optionnel car le cast peut ne pas marcher. Utilisation de as? pour avoir le resultat casté ou nil s'il ne marche pas.
        
        if let array = appDelegate.json["results"] as? Array<AnyObject>  {
            //Nous avons donc un array de AnyObject sur lequel nous voulons appliquer une fonction map permettant d'obenir un tableau de Comic : [AnyObject] -> [Comic]
            
            //map elle va transformer chq elem de votre array en comic 
            comicsArray = array.map
                { Comic(dict: $0 as! [String: AnyObject]) }
            
            print(comicsArray)

        }
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
        
        print("row \(indexPath.row)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

