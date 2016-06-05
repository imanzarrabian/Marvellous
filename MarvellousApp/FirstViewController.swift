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
    
    var artistsArray: [Artist]? = []
    var comicsArray: [Comic]? = []
    
    var artistsOffset: Int {
        return artistsArray!.count
    }
    var comicsOffset: Int {
        return comicsArray!.count
    }
    
    @IBAction func toggle(sender: UISegmentedControl) {
        comicTV.reloadData()
    }
    @IBOutlet weak var segmentedController: UISegmentedControl!


    @IBOutlet weak var comicTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicTV.estimatedRowHeight = 200.0
        comicTV.rowHeight = UITableViewAutomaticDimension
        
        displayMarvel("artist", offset: 0)
        displayMarvel("comic", offset: 0)
        
        //On accede à l'instance de l'AppDelegate
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //on unwrapp le contenu de appDelegate.json["results"] qui est optionnel car le champs "results" peut ne pas exister
        //on cast par la même occasion ce contenu en un objet Array<AnyObject>
        //le resultat de l'expression à droite du signe égal est un optionnel car le cast peut ne pas marcher. Utilisation de as? pour avoir le resultat casté ou nil s'il ne marche pas.
        
//        if let array = appDelegate.json["results"] as? Array<AnyObject>  {
//            //Nous avons donc un array de AnyObject sur lequel nous voulons appliquer une fonction map permettant d'obenir un tableau de Comic : [AnyObject] -> [Comic]
//            
//            //map elles va transformer chq elem de votre array en comic
//            
//
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let cell = sender as? ComicCell,
            let indexPath = comicTV.indexPathForCell(cell),
            let vc = segue.destinationViewController as? DetailsViewController else {
                return
        }
        
        let comic = comicsArray![indexPath.row]
        print("comic \(comic.title)")
        vc.comic = comic
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FirstViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(segmentedController.selectedSegmentIndex) {
        case 0:
            return (comicsArray?.count ?? 0) + 1
        case 1:
            return (artistsArray?.count ?? 0) + 1
        default:
            return (comicsArray?.count ?? 0) + 1
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(segmentedController.selectedSegmentIndex) {
        case 0:
            if let array = comicsArray {
                if indexPath.row == array.count {
                    let cell = tableView.dequeueReusableCellWithIdentifier("LoadMoreCell", forIndexPath: indexPath)
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("ComicCell", forIndexPath: indexPath) as! ComicCell
                    
                    let comic = array[indexPath.row]
                    
                    cell.title?.text = comic.title
                    
                    cell.issueNumber?.text = "Issue #\(comic.issueNumber)"
                    
                    if comic.description == "" {
                        cell.comicDesc?.text = "No desc. available."
                        cell.comicDesc?.textAlignment = NSTextAlignment.Center
                    } else {
                        cell.comicDesc?.text = "\(comic.description)"
                        cell.comicDesc?.textAlignment = NSTextAlignment.Justified
                    }
                    
                    if comic.isbn != "" {
                        cell.isbn?.text = "ISBN: \(comic.isbn)"
                    } else {
                        cell.isbn?.text = ""
                    }
                    
                    if comic.price == 0 {
                        cell.price?.text = "FREE"
                        cell.price?.textColor = UIColor(red:0.84, green:0.18, blue:0.18, alpha:1.0)
                    } else {
                        cell.price?.text = "$\(comic.price)"
                        cell.price?.textColor = UIColor(red:0, green:0, blue:0, alpha:1.0)
                    }
                    
                    Alamofire.request(.GET, "\(comic.thumbnail)").response { (request, response, data, error) in
                        cell.comicPic.image = UIImage(data: data!, scale:1)
                    }
                    
                    print("row \(indexPath.row)")
                    return cell
                }
            }
        case 1:
            if let array = artistsArray {
                if indexPath.row == array.count {
                    let cell = tableView.dequeueReusableCellWithIdentifier("LoadMoreCell", forIndexPath: indexPath)
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell", forIndexPath: indexPath) as! ArtistCell
                    
                    let artist = array[indexPath.row]
                    
                    cell.fullNameLabel?.text = artist.fullName
                    
                    print("row \(indexPath.row)")
                    return cell
                }
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch(segmentedController.selectedSegmentIndex) {
        case 0:
            displayMarvel("comic", offset: comicsOffset)
        case 1:
            displayMarvel("artist", offset: artistsOffset)
        default:
            break
        }
    }
    
    
    func displayMarvel(type: String, offset: Int) {
        switch type {
        case "comic":
            Comic.getRemoteComics(offset) {response in
                switch response.result {
                case .Success:
                    if let dict = response.result.value as? Dictionary<String, AnyObject> {
                        if let dictData = dict["data"] {
                            if let array = dictData["results"] as? Array<AnyObject> {
                                self.comicsArray! += array.map { Comic(dict: $0 as! [String : AnyObject]) }
                                self.comicTV.reloadData()
                            }
                        }
                    }
                case .Failure(let error):
                    print(error)
                }
            }
        case "artist":
            Artist.getRemoteArtists(offset) {response in
                switch response.result {
                case .Success:
                    if let dict = response.result.value as? Dictionary<String, AnyObject> {
                        if let dictData = dict["data"] {
                            if let array = dictData["results"] as? Array<AnyObject> {
                                self.artistsArray! += array.map { Artist(dict: $0 as! [String : AnyObject]) }
                                self.comicTV.reloadData()
                            }
                        }
                    }
                case .Failure(let error):
                    print(error)
                }
            }
        default:
            break
        }
    }
}