//
//  MediaFileExtraction.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Photos

import UIKit
import  Photos

class MediaFileExtraction: NSObject {
    
    var fileManager = FilesManager.shared

    public func getPhoto(for path: String) -> UIImage? {
        if let url = FilesManager.shared.documentURL(withPath: path) {
            if FilesManager.shared.exists(fileAt: url) {
                if let image = UIImage(contentsOfFile: url.path) {
                    return image
                }
            }
        }
        return nil
    }

}
