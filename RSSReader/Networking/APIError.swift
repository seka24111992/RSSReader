//
//  APIError.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public enum APIError: Error {
    
    case noDataInResponse
    case outOfDateVersion
    case notAuthorized
    case invalidDecoder
    case decodingFailed(error: Error)
    case badRequest(statusCode: Int)
    case serverError(key: String, message: String)
    case validationError(key: String, message: String)
    case versionIncompatible(updatedDate: String, updatedByName : String, serverId: Int)
    case syncObjectDeleted
}
