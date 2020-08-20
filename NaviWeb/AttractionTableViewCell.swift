//
//  AttractionTableViewCell.swift
//  NaviWeb
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {
    @IBOutlet weak var attractionLabel: UILabel!
    
    @IBOutlet weak var attractionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
