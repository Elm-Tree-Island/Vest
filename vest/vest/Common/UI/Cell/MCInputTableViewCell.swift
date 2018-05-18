//
//  MCInputTableViewCell.swift
//  VEST
//
//  Created by Mark on 2018/5/18.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCInputTableViewCell: UITableViewCell {
    @IBOutlet weak var editField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
