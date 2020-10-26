//
//  AsyncOperation.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

open class AsyncOperation: Operation {
    
    // MARK: - Controller
    
    public class Controller {
        
        fileprivate weak var operation: AsyncOperation?
        
        public var isCancelled: Bool {
            return operation?.isCancelled ?? false
        }
        
        public var isExecuting: Bool {
            return operation != nil
        }
        
        public private(set) var seeds = [Any]()
        
        fileprivate init(operation: AsyncOperation) {
            self.operation = operation
        }
        
        public func registerSeed(_ seed: Any) {
            seeds.append(seed)
        }
        
        public func complete() {
            if let operation = operation {
                operation.completeOperation()
            }
        }
    }
    
    // MARK: - Properties
    
    private var _isExecuting: Bool = false
    private var _isFinished: Bool = false
    
    open override var isConcurrent: Bool {
        return true
    }
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    open private(set) override var isExecuting: Bool {
        get {
            return _isExecuting
        }
        set {
            _isExecuting = newValue
        }
    }
    
    
    open private(set) override var isFinished: Bool {
        get {
            return _isFinished
        }
        set {
            _isFinished = newValue
        }
    }
    
    private var controller: Controller?
    private let block: (Controller) -> Void
    private let cancelling: ((Controller) -> Void)?
    
    // MARK: - Constructor
    
    public init(block: @escaping (Controller) -> Void, cancelling: ((Controller) -> Void)? = nil) {
        self.block = block
        self.cancelling = cancelling
    }
    
    open override func start() {
        startOperation()
        
        let controller = Controller(operation: self)
        if isCancelled {
            completeOperation()
            return
        }
        
        self.controller = controller
        block(controller)
    }
    
    open override func cancel() {
        if let controller = controller, let cancelling = cancelling {
            cancelling(controller)
        }
        super.cancel()
    }
    
    private func startOperation() {
        willChangeValue(forKey: "isExecuting")
        willChangeValue(forKey: "isFinished")
        
        isExecuting = true
        isFinished = false
        
        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
    }
    
    private func completeOperation() {
        willChangeValue(forKey: "isExecuting")
        willChangeValue(forKey: "isFinished")
        
        isExecuting = false
        isFinished = true
        
        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
    }
    
}
