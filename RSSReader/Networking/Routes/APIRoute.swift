//
//  APIRoute.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Alamofire

public struct APIRoute<Result> {
    
    public var routeURL = ""
    public var needAuthorization = false
    public var method = HTTPMethod.get
    public var parameters = [String: Any]()
    public var encoding: ParameterEncoding = URLEncoding()
    public var decoder: ResponseDecoder<Result>
    
    public init(decoder: ResponseDecoder<Result>) {
        self.decoder = decoder
    }
    
}
