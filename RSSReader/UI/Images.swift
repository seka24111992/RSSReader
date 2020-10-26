//
//  Images.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

open class Images {
    
    // MARK: - Singleton
    
    public static let shared = Images()
    
    private lazy var localBundle: Bundle = Bundle(for: Images.self)
    
    // MARK: - Properties
    
    open var isReadIcon: UIImage? {
        return UIImage(named: "icon-readable")
    }
    
    open var blankNewsAvatar: UIImage? {
        return UIImage(named: "icon-user")
    }
    
    open var settingsIcon: UIImage? {
        return UIImage(named: "tab-icon-settings")
    }
    
    
    // MARK: - Constructor
    
    private init() {
    }
    
}
