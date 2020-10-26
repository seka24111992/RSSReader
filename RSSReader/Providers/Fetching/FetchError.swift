//
//  FetchError.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public enum FetchError: Error {
    
    case authorizationFailed
    case noNetworkConnection
    case outOfDateVersion
    case remoteError(name: String, message: String)
    case error(error: Error)
    case noPermissions
    case validationError(key: String, message: String)
    case versionIncompatible(updatedDate: String, updatedByName : String, serverId: Int)
    case syncObjectDeleted
}
