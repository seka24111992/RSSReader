//
//  DataRequestPreparator.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Alamofire

public protocol DataRequestPreparator: NSObjectProtocol {
    
    func prepare(dataRequest: DataRequest) -> DataRequest
    
}
