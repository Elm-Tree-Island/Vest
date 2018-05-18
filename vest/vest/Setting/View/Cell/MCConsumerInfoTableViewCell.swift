//
//  MCConsumerInfoTableViewCell.swift
//  VEST
//
//  Created by Mark on 2018/5/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCConsumerInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNum: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
