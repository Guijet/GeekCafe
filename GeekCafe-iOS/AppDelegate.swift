//
//  AppDelegate.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-08-30.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Stripe
import AFNetworking
import GoogleMaps
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Stripe.setDefaultPublishableKey("pk_test_8tGMOp2AUxHPPKunjW6PnZwk")
        GMSServices.provideAPIKey("AIzaSyAB_DuRMN3fh1tUlNIsw405-hQghA4lqRw")
        Global.global.ip = "http://api.guijethostingtools.com/"
        Global.global.fbResult = ""
        Global.global.userInfo = User(firstname: "", lastname: "", email: "", sexe: "", birthdate: "", phone: "", id: 0, image_url: "", token: "", abonnement: Abonnement(id:0,title:"",description:"",perk:"",point_reward:0,discount:0,price:0 as NSNumber),points: 0, cards: [userCard]())
        Global.global.itemsOrder = [itemOrder]()
        Global.global.isFbUser = false
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        setupPushDelegate(application: application)
        

        return true
    }
    func setupPushDelegate(application: UIApplication) {
        UNUserNotificationCenter.current().delegate  = self
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        application.registerForRemoteNotifications()
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //  DispatchQueue.global(qos: .background).async {}
        completionHandler()
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.badge, UNNotificationPresentationOptions.sound])
    }
    
    //GET ACCESS TOKEN
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

