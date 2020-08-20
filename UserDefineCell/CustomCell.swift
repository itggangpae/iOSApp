//
//  CustomCell.swift
//  UserDefineCell
//
//  Created by Munseok Park on 2020/08/17.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
           super.setHighlighted(highlighted, animated: animated)
           self.backgroundColor = highlighted ? UIColor.yellow : UIColor.clear
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
