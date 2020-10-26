//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var newsIconImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = isSelected ? 4 : 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = Appearance.shared.lightGreyColor.cgColor
        isSelected = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
