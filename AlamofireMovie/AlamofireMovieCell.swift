//
//  AlamofireMovieCell.swift
//  AlamofireMovie
//
//  Created by Munseok Park on 2020/08/24.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class AlamofireMovieCell: UITableViewCell {
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
