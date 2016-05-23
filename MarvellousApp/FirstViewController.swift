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
        //On accede à l'instance de l'AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //on unwrapp le contenu de appDelegate.json["results"] qui est optionnel car le champs "results" peut ne pas exister
        //on cast par la même occasion ce contenu en un objet Array<AnyObject>
        //le resultat de l'expression à droite du signe égal est un optionnel car le cast peut ne pas marcher. Utilisation de as? pour avoir le resultat casté ou nil s'il ne marche pas.
        
        if let array = appDelegate.json["results"] as? Array<AnyObject>  {
            //Nous avons donc un array de AnyObject sur lequel nous voulons appliquer une fonction map permettant d'obenir un tableau de Comic : [AnyObject] -> [Comic]
            
            //map elle va transformer chq elem de votre array en comic 
            print(array)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

