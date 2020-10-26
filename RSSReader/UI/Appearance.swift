//
//  Appearance.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit
//import BEMCheckBox
//import QuickLook

open class Appearance: NSObject {
    
    // MARK: - UI Constants
    
    public struct UIConsts {
        
    }
    
    // MARK: - Singleton
    
    public static let shared = Appearance()
    
    // MARK: - Properties
    
    public var purpleColor: UIColor {
        return UIColor(red: 0xB8, green: 0x86, blue: 0xCE)
    }
    
    public var blueColor: UIColor {
        return UIColor(red: 0x21, green: 0x96, blue: 0xF3)
    }
    
    public var lightPurpleColor: UIColor {
        return UIColor(red: 0xE6, green: 0xE6, blue: 0xFA)
    }
    
    public var lightGreyColor: UIColor {
        return UIColor(red: 0xEB, green: 0xE8, blue: 0xEC)
    }
    
    public var lightGreyTransparentColor: UIColor {
        return UIColor(red: 255, green: 255, blue: 255, alpha: 0.1)
    }
    
    public var midGreyColor: UIColor {
        return UIColor(red: 0xC4, green: 0xC4, blue: 0xC4)
    }
    
    public var darkGreyColor: UIColor {
        return UIColor(red: 0x85, green: 0x85, blue: 0x85)
    }
    
    public var greenColor: UIColor {
        return UIColor(red: 0x33, green: 0x99, blue: 0x00)
    }
    
    public var redColor: UIColor {
        return UIColor(red: 0xFF, green: 0x05, blue: 0x00)
    }
    
    public var orangeColor: UIColor {
        return UIColor(red: 0xFF, green: 0x98, blue: 0x01)
    }
    
    open var navigationBarColor: UIColor {
        return UIColor(red: 0x61, green: 0xAD, blue: 0xB3)
    }
    
    open var tapBarColor: UIColor {
        return UIColor(red: 0x21, green: 0x96, blue: 0xF3)
    }
    
    open var searchBarColor: UIColor {
        return UIColor(red: 0x21, green: 0x96, blue: 0xF3)
    }
    
    open var navigationBarFont: UIFont {
        return UIFont(name: "Nunito-Bold", size: 17) ?? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    }
    open var navigationBarItemFont: UIFont {
        return UIFont(name: "Nunito-Regular", size: 17) ?? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    }
    open var regularFont: UIFont {
        return UIFont(name: "Nunito-Regular", size: 13) ?? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    }

    
    // MARK: - Constructor
    
    public override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    public func apply(window: UIWindow) {
        UITabBar.appearance().barTintColor = Appearance.shared.tapBarColor
        UITabBar.appearance().tintColor = UIColor.white
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = UIColor.white
        } else {
            UITabBar.appearance().tintColor = UIColor.white
        }
        
        UINavigationBar.appearance().backgroundColor = Appearance.shared.navigationBarColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = Appearance.shared.navigationBarColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: navigationBarFont]
    }
    
    public func setColorToStatusBar(color: UIColor) {
        guard let statusBarView = UIApplication.shared.statusBarUIView else { return }
        
        if #available(iOS 13, *) {
            statusBarView.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBarView)
        } else {
            if statusBarView.responds(to: #selector(setter: UIView.backgroundColor)) {
                statusBarView.backgroundColor = color
            }
        }
    }
}
