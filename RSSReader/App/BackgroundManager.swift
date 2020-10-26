//
//  BackgroundManager.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

public class BackgroundManager {
    
    // MARK: - Singleton
    
    public static let shared = BackgroundManager()
    
    // MARK: - Properties
    
    private var syncTaskId = UIBackgroundTaskIdentifier.invalid
    
    // MARK: - Constructor
    
    private init() {
    }
    
    // MARK: - Methods
    
    public func startBackgroundTasks() {
        syncTaskId = UIApplication.shared.beginBackgroundTask(withName: "SyncTask") {
            UIApplication.shared.endBackgroundTask(self.syncTaskId)
            self.syncTaskId = UIBackgroundTaskIdentifier.invalid
        }
        
        DispatchQueue.global(qos: .background).async {
            SynchronizationManager.shared.waitUntilAllOperationsAreFinished()
            
            UIApplication.shared.endBackgroundTask(self.syncTaskId)
            self.syncTaskId = UIBackgroundTaskIdentifier.invalid
        }
    }
    
    public func stopBackgroundTasks() {
        UIApplication.shared.endBackgroundTask(syncTaskId)
        syncTaskId = UIBackgroundTaskIdentifier.invalid
    }
    
}
