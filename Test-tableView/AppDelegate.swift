//
//  AppDelegate.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navc = UINavigationController(rootViewController: MainTabBarController())
        
        window?.rootViewController = navc
        window?.makeKeyAndVisible()
        return true
    }
}

