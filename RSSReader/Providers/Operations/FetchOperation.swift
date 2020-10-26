//
//  FetchOperation.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public class FetchOperation<Result>: NSObject {
    
    private weak var sender: NSObject?
    private let selector: Selector
    private let options: [String: Any]
    
    public init(sender: NSObject?, selector: Selector, options: [String: Any]) {
        self.sender = sender
        self.selector = selector
        self.options = options
    }
    
    public func execute(completed: @escaping (FetchResult<Result>) -> Void) {
        var executionOptions = options
        executionOptions[FetchOperationOption.handler] = completed
        if let sender = sender {
            sender.performSelector(inBackground: selector, with: executionOptions)
        } else {
            completed(.failure(error: .error(error: FetchOperationError.executionError)))
        }
    }
}
