//
//  Window.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

public class Window: UIWindow {
    
    // MARK: - Constructors/Destructor
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initUI()
    }
    
    deinit {
        deinitUI()
    }
    
    // MARK: - Initialization
    
    private func initUI() {
    }
    
    private func deinitUI() {
    }
}
