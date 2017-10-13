//
//  AppDelegate.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 10.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }
    
    fileprivate func setupAppearance() {
        let font = UIFont(name: "Futura-Medium", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        UINavigationBar.appearance().barTintColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: font]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: font], for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: font], for: .normal)
    }
}

