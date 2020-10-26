//
//  UIViewController+ActivityIndicator.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public class ActivityIndicatorView: UIActivityIndicatorView {
    }
    
    private var indicatorView: UIActivityIndicatorView? {
        return view.subviews.first(where: { $0 is ActivityIndicatorView }) as? UIActivityIndicatorView
    }
    
    public func presentActivityIndicator() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                [weak self] in
                
                self?.presentActivityIndicator()
            }
            return
        }
        
        guard self.indicatorView == nil else {
            return
        }
        
        let indicatorView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        indicatorView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        indicatorView.backgroundColor = UIColor.white
        indicatorView.color = UIColor.black
        indicatorView.alpha = 0.5
        
        navigationController?.navigationBar.isUserInteractionEnabled = false
        
        view.addSubview(indicatorView)
        
        indicatorView.startAnimating()
    }
    
    public func dismissActivityIndicator() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                [weak self] in
                
                self?.dismissActivityIndicator()
            }
            return
        }
        
        navigationController?.navigationBar.isUserInteractionEnabled = true
        
        if let indicatorView = indicatorView {
            indicatorView.stopAnimating()
            indicatorView.removeFromSuperview()
        }
    }
}
