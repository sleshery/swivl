//
//  UserCellTableViewCell.swift
//  swivl_test_task
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 FC. All rights reserved.
//

import UIKit

class UserCellTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarIV: UIImageView!
        
    @IBOutlet weak var loginL: UILabel!
    @IBOutlet weak var htmlUrlL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
