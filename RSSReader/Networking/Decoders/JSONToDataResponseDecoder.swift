//
//  JSONToDataResponseDecoder.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import SwiftyJSON

open class JSONToDataResponseDecoder: ResponseDecoder<Data?> {
    
    public final override func decode(response: HTTPURLResponse, data: Data?) throws -> Data? {
       return data
    }
}
