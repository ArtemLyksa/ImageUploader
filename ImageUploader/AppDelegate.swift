//
//  AppDelegate.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator: MainCoordinator?
    private var dbService: DataBaseService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        dbService = DataBaseService(manager: CoreDataManager())
        coordinator = MainCoordinator(window: window, dbService: dbService!)
        coordinator?.start()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        dbService?.synchronize()
    }
    
}

