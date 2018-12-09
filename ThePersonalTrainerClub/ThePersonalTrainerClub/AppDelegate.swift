//
//  AppDelegate.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 27/10/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        
        NotificationCenter.default.addObserver(self,
           selector: #selector(webServiceDidReceiveData(_:)),
           name: .WebServiceDidReceiveData,
           object: nil)
        
        if (UserSettings.token.isEmpty) {
            switchToLoginViewController()
        } else {
            switchToMainViewController();
        }
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func switchToLoginViewController(sessionExpired: Bool = false) {
        let loginVC = LoginViewController(sessionExpired: sessionExpired).embedInNavigationController()
        window?.rootViewController = loginVC
    }
    
    func switchToMainViewController() {
        let trainerDashboardVC = TrainerDashboardViewController()
        window?.rootViewController = trainerDashboardVC
    }
    
    @objc
    func webServiceDidReceiveData(_ notification: Notification) {
        let statusCode = notification.userInfo?["statusCode"] as! Int
        let endpoint = notification.userInfo?["endpoint"] as! Endpoint
        
        switch endpoint {
        case .login(_):
            return
        default:
            break
        }
        
        switch statusCode {
        case 401:
            UserSettings.token = ""
            UserSettings.user = nil
            switchToLoginViewController(sessionExpired: true)
        default:
            print("Web Service: \(statusCode)")
        }
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

