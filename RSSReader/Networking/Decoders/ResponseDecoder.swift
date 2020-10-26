//
//  ResponseDecoder.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

open class ResponseDecoder<Result> {
    
    open func decode(response: HTTPURLResponse, data: Data?) throws -> Result {
        throw APIError.invalidDecoder
    }
    
}
