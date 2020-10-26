//
//  Response+Status.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    private enum Header: String {
        case apiVersion = "ApiVersion"
    }
    
    public var isSuccessful: Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    public var unauthorized: Bool {
        return statusCode == 401
    }
    
    public var isBadRequest: Bool {
        return statusCode == 400
    }
    
}
