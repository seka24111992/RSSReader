//
//  UIViewController+Fetching.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIViewController {
    
    @discardableResult
    public func processFetching<Result>(_ result: FetchResult<Result>, allowCache: Bool = true) -> Result? {
        var fetchError: FetchError
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            fetchError = error
        }
        
        switch fetchError {
        case .authorizationFailed:
            break
        case .noNetworkConnection:
            break
        case .outOfDateVersion:
            DispatchQueue.main.async {
                
            }
            
        case .remoteError(_, let message):
            DispatchQueue.main.async {
        
            }
        case .error(let error):
            print("Fetching has been failed." + error.localizedDescription)
        case .validationError(_, let message):
            DispatchQueue.main.async { 
       
            }
            break
        case .syncObjectDeleted:
            break
        case .versionIncompatible:
            break
        case .noPermissions:
            break
        }
        return nil
    }
    
}
