//
//  AppDelegate.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit
import Foundation
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appearace: Appearance!
    
    // MARK: - Singleton
    
    public static var sharedDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    public static var coreDataStoreName: String {
        return "CoreData.sql"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: AppDelegate.coreDataStoreName)
        

        window = createWindow()
        openInitialPage()
        appearace = createAppearance()
        appearace.apply(window: window!)
        
        SynchronizationManager.shared.registerProvider(synchronizable: NewsProvider.shared)
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        return true
    }
    
    func openInitialPage() {
        Navigator().navigateToRSSFeed()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        SynchronizationManager.shared.startLastSync()
        APIClient.shared.stopReaching()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        BackgroundManager.shared.startBackgroundTasks()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        BackgroundManager.shared.stopBackgroundTasks()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        APIClient.shared.startReaching()
        SynchronizationManager.shared.startSync()
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
}


