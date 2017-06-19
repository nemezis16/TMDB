//
//  AppDelegate.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/17/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDataPath")
        URLCache.shared = cache
        
        return true
    }

}

