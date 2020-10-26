//
//  FetchResult.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Alamofire

public enum FetchResult<Result> {
    
    case success(value: Result)
    case failure(error: FetchError)
    
    public init(response: DataResponse<Result>) {
        
        switch response.result {
        case .success(let value):
            self = .success(value: value)
        case .failure(let error):
            switch error {
            case APIError.outOfDateVersion:
                self = .failure(error: .outOfDateVersion)
            case APIError.serverError(let name, let message):
                self = .failure(error: .remoteError(name: name, message: message))
            case APIError.validationError(let key, let message):
                self = .failure(error: .validationError(key: key, message: message))
            case APIError.versionIncompatible(let updatedDate, let updatedByName, let serverId):
                self = .failure(error: .versionIncompatible(updatedDate: updatedDate, updatedByName: updatedByName, serverId: serverId))
            case APIError.syncObjectDeleted:
                self = .failure(error: .syncObjectDeleted)
            default:
                self = .failure(error: .error(error: error))
            }
        }
    }
    
}
