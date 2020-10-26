//
//  AppDelegate+Initialization.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    
    open func createWindow() -> UIWindow {
        return Window(frame: UIScreen.main.bounds)
    }
    
    open func createRootViewController() -> UIViewController? {
        return UIStoryboard(name: "Main", bundle: Bundle(for: AppDelegate.self)).instantiateInitialViewController()
    }
    
    open func createAppearance() -> Appearance {
        return Appearance()
    }
    
}
