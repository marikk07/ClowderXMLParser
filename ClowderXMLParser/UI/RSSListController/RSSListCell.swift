//
//  RSSListCell.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import UIKit
import SDWebImage

class RSSListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(_ item: RSSItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        if let url = URL(string: item.icon ?? "") {
            iconImageView.sd_setImage(with: url)
        }
    }
}
