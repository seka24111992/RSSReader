//
//  MultiFetchOperation.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public class MultiFetchOperation<First, Second>: FetchOperation<(First, Second)> {
    
    private let firstOperation: FetchOperation<First>
    private let secondOperation: FetchOperation<Second>
    
    public init(firstOperation: FetchOperation<First>, secondOperation: FetchOperation<Second>) {
        self.firstOperation = firstOperation
        self.secondOperation = secondOperation

        super.init(sender: nil, selector: #selector(getter: value), options: [:])
    }

    public override func execute(completed: @escaping (FetchResult<(First, Second)>) -> Void) {
        firstOperation.execute {
            firstResult in
            
            var firstValue: First!
            var cachedError: FetchError?
            
            switch firstResult {
            case .failure(let error):
                completed(.failure(error: error))
                return
            case .success(let value):
                firstValue = value
            }
            
            self.secondOperation.execute {
                secondResult in
                
                switch secondResult {
                case .failure(let error):
                    completed(.failure(error: error))
                case .success(let value):
                    completed(.success(value: (firstValue, value)))
                }
            }
        }
    }
    
    @objc private var value: Int {
        return hashValue
    }
    
}

extension FetchOperation {
    
    public func then<OperationResult>(_ operation: FetchOperation<OperationResult>) -> MultiFetchOperation<Result, OperationResult> {
        return MultiFetchOperation(firstOperation: self, secondOperation: operation)
    }
    
}
