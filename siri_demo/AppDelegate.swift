//
//  AppDelegate.swift
//  siri_demo
//
//  Created by jxy on 21/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import UIKit
import Intents;
import DemoKit;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let myVocab = ["开空调", "关空调", "蚂蚁森林"]
        let myVocabSet = NSOrderedSet(array: myVocab) //Convert myVocab to an NSOrderedSet
        
        let vocabulary = INVocabulary.shared()
        vocabulary.setVocabularyStrings(myVocabSet, of: .contactName);
        Utils.sharded.openURL = { UIApplication.shared.open($0, options: [:], completionHandler: nil)}
        
        initWebServer();
        
        Utils.sharded.load(url: URL(string:"http://127.0.0.1:12345/test")!)
        
        
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print(url);
        return true;
    }
    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        print(userActivity.description);
        
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool{
        print(userActivity.description)
        if(userActivity.activityType.elementsEqual("INSendMessageIntent")){
            Utils.sharded.load(url:URL(string:((userActivity.interaction?.intent as! INSendMessageIntent).content)!)!);
        }
        return true;
    }
    func application(_ application: UIApplication, handle intent: INIntent, completionHandler: @escaping (INIntentResponse) -> Void) {
        print(intent);
        
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        UIApplication.shared.beginBackgroundTask(expirationHandler: nil);
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

