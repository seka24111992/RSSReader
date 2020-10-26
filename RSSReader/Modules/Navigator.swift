//
//  Navigator.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    
    // MARK: - Identifiers
    
    fileprivate enum Identifiers: String {
        case RSSFeedViewController = "RSSFeedViewController"
    }
    
    private var _controller : UIViewController? = nil
    
    public init(controller : UIViewController? = nil) {
        _controller = controller
    }
    
    public func navigateToRSSFeed() {
        let RSSFeedViewController = Navigator.RSSFeedViewController
        let navController = UINavigationController(rootViewController: RSSFeedViewController)
        UIApplication.shared.delegate?.window??.rootViewController = navController
    }
    

    
    public static var RSSFeedViewController: RSSFeedViewController {
        get {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AppDelegate.self))
            return storyboard.instantiateViewController(withIdentifier: Identifiers.RSSFeedViewController.rawValue) as! RSSFeedViewController
        }
    }
}
