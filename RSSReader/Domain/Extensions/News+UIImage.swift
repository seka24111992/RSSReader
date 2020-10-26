//
//  News+UIImage.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension News {
    func setThumbnail(thumbnailImage: UIImageView) {
        let placeholderImage = Images.shared.blankNewsAvatar
        thumbnailImage.sd_cancelCurrentImageLoad()
        
        if let thumbnailPath = self.localThubnailPath {
            News.setLocalThumbnail(thumbnailImage: thumbnailImage, thumbnailPath: thumbnailPath)
        } else if let externalThumbnail = self.externalThubnailPath {
            News.tryLoadExternalThumbnail(thumbnailImage: thumbnailImage, thumbnailPath: externalThumbnail, news: self)
        } else {
            thumbnailImage.image = placeholderImage
        }
    }
    
    static private func setLocalThumbnail(thumbnailImage: UIImageView, thumbnailPath: String) {
        thumbnailImage.image = nil
        thumbnailImage.image = MediaFileExtraction().getPhoto(for: thumbnailPath)
    }
    
    static private func tryLoadExternalThumbnail(thumbnailImage: UIImageView, thumbnailPath: String, news: News) {
        let placeholderImage = Images.shared.blankNewsAvatar
        thumbnailImage.sd_setImage(with: URL(string: thumbnailPath)) { (image, error, type, url) in
            if error != nil {
                if let externalPath = news.externalThubnailPath {
                    thumbnailImage.sd_setImage(with: URL(string: externalPath)) { (image, error, type, url) in
                        if error != nil {
                            thumbnailImage.image = placeholderImage
                        }
                    }
                }
            }
        }
    }
}
