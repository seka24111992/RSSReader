//
//  News.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

open class News: NSObject {
    open var uuid = UUID(uuid: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    open var title: String? = nil
    open var source: String? = nil
    open var newsDescription: String? = nil
    open var externalThubnailPath: String? = nil
    open var localThubnailPath: String? = nil
    open var isOpen: Bool = false
    open var createDate = Date()
    open var link: String? = nil
}
