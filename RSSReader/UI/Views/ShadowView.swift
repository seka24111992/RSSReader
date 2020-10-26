//
//  ShadowView.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.masksToBounds = false
        layer.shadowColor = Appearance.shared.navigationBarColor.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: -5, height: 5)
        layer.shadowRadius = 5
        layer.cornerRadius = 5
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
        
    }
    
}
