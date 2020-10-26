//
//  URLRequestPreparator.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public protocol URLRequestPreparator: NSObjectProtocol {
    
    func prepare(urlRequest: URLRequest) -> URLRequest
    
}
