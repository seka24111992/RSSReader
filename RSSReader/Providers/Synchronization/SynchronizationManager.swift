//
//  SynchronizationManager.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    public static let SynchronizationManagerDidSyncComplete = Notification.Name(rawValue: "SynchronizationManagerDidSyncCompleteNotification")
}

open class SynchronizationManager: NSObject {
    
    // MARK: - Sync Constants
    
    private struct SyncConsts {
//        static let interval: TimeInterval = 60
        static let queueMonitorInterval: TimeInterval = 2
    }
    
    // MARK: - Singleton
    
    public static let shared = SynchronizationManager()
    
    // MARK: - Properties
    
    private let operationQueue: OperationQueue = {
        let result = OperationQueue()
        result.maxConcurrentOperationCount = 1
        return result
    }()
    private let syncLock = NSRecursiveLock()
    private var syncTimer: Timer?
    private var queueMonitorTimer: Timer?
    private var isWaitForForceSync: Bool = false
    
    private var providers = [WeakReference<Synchronizable>]()
    
    public private(set) var isActive = false
    
    public var isSynchronizing: Bool {
        syncLock.lock()
        let result = !operationQueue.operations.isEmpty
        syncLock.unlock()
        return result
    }
    
    public var canStartSyncrhonization: Bool {
        syncLock.lock()
        let result = isActive && !isSynchronizing
        syncLock.unlock()
        return result
    }
    
    private var updateInterval: UpdateInterval {
        get {
            return PreferencesService.shared.updateInterval
        }
    }
    
    // MARK: - Constructor
    
    private override init() {
        super.init()
        
    }
    
    deinit {
    }
    
    
    // MARK: - Methods
    
    private func getUpdateInterval(_ interval: UpdateInterval) -> TimeInterval {
        switch interval {
        case .minute:
            return 60
        case .tenMinutes:
            return 10*60
        case .thirtyMinutes:
            return 30*60
        }
    }
    
    open func registerProvider(synchronizable: Synchronizable) {
        syncLock.lock()
        
        if let _ = providers.index(where: { ($0.value as AnyObject) === (synchronizable as AnyObject) }) {} else {
            providers.append(WeakReference(value: synchronizable))
        }
        
        syncLock.unlock()
    }
    
    open func startSync() {
        syncLock.lock()
        
        if let timer = syncTimer {
            timer.invalidate()
            syncTimer = nil
        }
        
        isActive = true
        syncTimer = Timer.scheduledTimer(timeInterval: self.getUpdateInterval(updateInterval), target: self, selector: #selector(timerTicked(timer:)), userInfo: nil, repeats: true)
        checkPendingChanges()
        
        syncLock.unlock()
    }
    
    open func stopSync() {
        syncLock.lock()
        
        if let timer = queueMonitorTimer {
            timer.invalidate()
            queueMonitorTimer = nil
        }
        
        if let timer = syncTimer {
            timer.invalidate()
            syncTimer = nil
        }
        
        isActive = false
        
        syncLock.unlock()
    }
    
    open func sync() {
        syncLock.lock()
        if !canStartSyncrhonization {
            return
        }
        
        if let timer = queueMonitorTimer {
            timer.invalidate()
            queueMonitorTimer = nil
        }
        
        for provider in providers {
            if let provider = provider.value {
                
                let operations = provider.syncOperations;
                
                if !operations.isEmpty {
                    queueMonitorTimer = Timer.scheduledTimer(timeInterval: SyncConsts.queueMonitorInterval, target: self, selector: #selector(checkQueue(timer:)), userInfo: nil, repeats: true)
                }
                
                operationQueue.addOperations(operations, waitUntilFinished: false)
            }
        }
        
        syncLock.unlock()
    }
    
    open func waitUntilAllOperationsAreFinished() {
        operationQueue.waitUntilAllOperationsAreFinished()
    }
    
    open func startLastSync() {
        self.sync()
        self.stopSync()
    }
    
    open func forceSync() {
        syncLock.lock()
        if isSynchronizing {
            isWaitForForceSync = true
        } else {
            self.sync()
        }
        syncLock.unlock()
    }
    
    // MAKR: - Handler
    
    @objc
    private func checkPendingChanges() {
        syncLock.lock()
        if !canStartSyncrhonization {
            return
        }
        
        if let _ = providers.first(where: { $0.value.map { !$0.syncOperations.isEmpty } ?? false}) {
            sync()
        }
        
        syncLock.unlock()
    }
    
    @objc
    private func timerTicked(timer: Timer) {
        syncLock.lock()
        checkPendingChanges()
        syncLock.unlock()
    }
    
    @objc
    private func checkQueue(timer: Timer) {
        
        if operationQueue.operations.isEmpty {
            queueMonitorTimer?.invalidate()
            if let timer = syncTimer {
                timer.invalidate()
                syncTimer = nil
            }
            
            if isWaitForForceSync {
                isWaitForForceSync = false
                self.sync()
            } else {
                NotificationCenter.default.post(name: .SynchronizationManagerDidSyncComplete, object: nil)
            }
            
            syncTimer = Timer.scheduledTimer(timeInterval: self.getUpdateInterval(updateInterval), target: self, selector: #selector(timerTicked(timer:)), userInfo: nil, repeats: true)
        }
    }
}

