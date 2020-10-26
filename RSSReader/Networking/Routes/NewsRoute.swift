//
//  NewsRoute.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Alamofire

public enum NewsAPIRoutes {
    
    public static func getNews(from url: String) -> APIRoute<[News]> {
        var route = APIRoute(decoder: NewsDataResponseDecoder())
        route.routeURL = url
        route.method = HTTPMethod.get
        route.needAuthorization = false
        route.parameters = [:]
        route.encoding = URLEncoding()
        return route
    }
}


