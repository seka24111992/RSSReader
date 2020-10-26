//
//  APIRequest.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

open class APIRequest<Result> {
    
    // MARK: - Properties
    
    private var serializer: DataResponseSerializer<Result>!
    
    public let manager: SessionManager
    public let route: APIRoute<Result>
    public private(set) var prepare = true
    
    public weak var urlRequestPreparator: URLRequestPreparator?
    public weak var dataRequestPreparator: DataRequestPreparator?
    
    // MARK: - Constructor/Destructor
    
    public init(manager: SessionManager, route: APIRoute<Result>) {
        self.manager = manager
        self.route = route
        
        let decoder = route.decoder
        self.serializer = DataResponseSerializer<Result> {
            request, response, data, error in
            
            
            if let error = error {
                return .failure(error)
            }
            
            guard let response = response else {
                return .failure(APIError.noDataInResponse)
            }
            
            do {
                let value = try decoder.decode(response: response, data: data)
                return .success(value)
            }
            catch let error {
                return .failure(error)
            }
        }
    }
    
    public func withPreparations(_ prepare: Bool) -> Self {
        self.prepare = prepare
        return self
    }
    
    @discardableResult
    public func response(completionHander: @escaping (DataResponse<Result>) -> Void) -> Self {
        return response(token: nil, completionHander: completionHander)
    }
    
    @discardableResult
    private func response(token: String?, completionHander: @escaping (DataResponse<Result>) -> Void) -> Self {
        if route.needAuthorization {
            
        }
        
        var request = URLRequest(url: URL(string: route.routeURL)!)
        request.httpMethod = route.method.rawValue
        
        do {
            request = try route.encoding.encode(request, with: route.parameters)
        }
        catch let error {
            print("API parameters hasn't been enconded." + error.localizedDescription)
        }
        if route.needAuthorization {
            
        }
        if prepare, let preparator = urlRequestPreparator {
            request = preparator.prepare(urlRequest: request)
        }
        
        var dataRequest = manager.request(request)
        if prepare, let preparator = dataRequestPreparator {
            
            dataRequest = preparator.prepare(dataRequest: dataRequest)
        }
        
        dataRequest.response(queue: DispatchQueue.global(qos: .background), responseSerializer: serializer) {
            response in
            
            if let error = response.error {
                print("API request failed." + error.localizedDescription)
            }
            completionHander(response)
        }
        return self
    }
}
