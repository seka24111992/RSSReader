//
//  Nibs.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

open class Nibs: NSObject  {
    
    // MARK: - Singleton
    
    public static let shared = Nibs()
    
    private lazy var localBundle: Bundle = Bundle(for: Nibs.self)
    
    // MARK: - Properties
    
    open var newsTableViewCell: UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: localBundle)
    }
    
    // MARK: - Constructor
    
    private override init() {
        super.init()
    }
    
}
