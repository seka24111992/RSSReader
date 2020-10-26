//
//  JSONResponseDecoder.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import SwiftyJSON

open class JSONResponseDecoder<Result>: ResponseDecoder<Result> {
    
    public final override func decode(response: HTTPURLResponse, data: Data?) throws -> Result {
        if let data = data {
            let json = try JSON(data: data, options: .allowFragments)
            if let error = json.error {
                throw APIError.decodingFailed(error: error)
            }
            return try decode(response: response, json: json)
        }
        throw APIError.noDataInResponse
    }
    
    open func decode(response: HTTPURLResponse, json: JSON) throws -> Result {
        throw APIError.invalidDecoder
    }
    
}
