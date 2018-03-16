//
//  StorageRecordTableViewCell.swift
//  VEST
//
//  Created by Mark on 2018/3/15.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class StorageRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivProductPic: UIImageView!           // 商品图片
    @IBOutlet weak var lblName: UILabel!                    // 商品名称
    @IBOutlet weak var lblSellingPrice: UILabel!            // 售价（RMB）
    @IBOutlet weak var lblSellingCount: UILabel!            // 销量
    @IBOutlet weak var lblLeftCount: UILabel!               // 库存量
    @IBOutlet weak var lblSalesValue: UILabel!              // 销售额
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
