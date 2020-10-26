//
//  APIClient.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension Notification.Name {
    
    static let APIReachabilityStatusChanged = Notification.Name(rawValue: "APIReachabilityStatusChangedNotification")
    
}

open class APIClient: NSObject, URLRequestPreparator, DataRequestPreparator {
    
    // MARK: - Singleton
    
    public static let shared = APIClient()
    
    // MARK: - Properties
    
    private var isListening: Bool = false
    
    private var networkService: SessionManager!
    private var reachabilityManager: NetworkReachabilityManager?
    
    public var isReachable: Bool {
        if let reachabilityManager = reachabilityManager, isListening {
            return reachabilityManager.isReachable
        }
        return true
    }
    
    // MARK: - Constructor/Destructor
    
    private override init() {
        
        super.init()
                
        initServices()
        
        reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
        reachabilityManager?.listener = {
            status in
            
            NotificationCenter.default.post(name: .APIReachabilityStatusChanged, object: nil, userInfo: nil)
        }
    }
    
    private func initServices() {
        
        networkService = SessionManager()
    }
    
    deinit {
        stopReaching()
        reachabilityManager = nil
    }
    
    // MARK: - Methods

    
    public func request<Result>(route: APIRoute<Result>) -> APIRequest<Result> {
        let request = APIRequest(manager: networkService, route: route)
        request.urlRequestPreparator = self
        request.dataRequestPreparator = self

        return request
    }
    
    // MARK: - URL Request Preparator
    
    public func prepare(urlRequest: URLRequest) -> URLRequest {
        let request = urlRequest
        
        return request
    }
    
    // MARK: - Data Request Preparator
    
    public func prepare(dataRequest: DataRequest) -> DataRequest {
        return dataRequest
    }
    
    // MARK: - Reachability
    
    public func startReaching() {
        if let reachabilityManager = reachabilityManager {
            isListening = true
            reachabilityManager.startListening()
        }
    }
    
    public func stopReaching() {
        if let reachabilityManager = reachabilityManager {
            reachabilityManager.stopListening()
        }
        isListening = false
    }
}

