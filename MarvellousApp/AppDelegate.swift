//
//  AppDelegate.swift
//  MarvellousApp
//
//  Created by Iman Zarrabian on 19/05/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var json: Dictionary<String,AnyObject> = [:]

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let filePath = NSBundle.mainBundle().pathForResource("comic", ofType: "json")
        
        if let path = filePath, let data = NSData(contentsOfFile: path) {
            
            
            //serializedDict est une AnyObject OPTIONNEL car l'operation de conversion de la data vers le json object peut échouer
            //d'ou le try?
            let serializedDict = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            //METHODE 1
            
//            //On unwrapp le serializedDict et on vérifie que qu'il est bien "castable" en Dictionary<String, AnyObject>
//            //nouveauté : "la clause where"
//            if let dict = serializedDict where serializedDict is [String : AnyObject] {
//                //si le type est castable alors on cast pour de vrai
//                json = dict as! Dictionary<String, AnyObject>
//            }
 
            //METHODE 2 : AUTRE MANIERE DE FAIRE LA MEME CHOSE
            
            //cette fois le as? retourne nil si serializedDict "n'est pas castable" et cast dans le cas opposé
            if let dict2 = serializedDict as? Dictionary<String, AnyObject> {
                json = dict2
            }
        }
        else {
            print("no mock found")
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

