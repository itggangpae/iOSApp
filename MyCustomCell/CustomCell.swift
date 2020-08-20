//
//  CustomCell.swift
//  MyCustomCell
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func imageSwitch(_ sender: Any) {
        //셀의 인덱스 가져오기
        let tableView = self.superview! as! UITableView
        let indexPath = tableView.indexPath(for: self)
        
        let imageSwitch = sender as! UISwitch
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if imageSwitch.isOn{
             imgView.image = UIImage(named: delegate.image1[indexPath!.row])
        }else{
            imgView.image = UIImage(named: delegate.image2[indexPath!.row])
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
