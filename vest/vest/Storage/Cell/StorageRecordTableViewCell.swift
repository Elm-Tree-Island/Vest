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
    @IBOutlet weak var lblCostPrice: UILabel!               // 进货价
    
    @IBOutlet weak var lblSellingCount: UILabel!            // 销量
    @IBOutlet weak var lblLeftCount: UILabel!               // 库存量
    
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithModel(_ model:MCStorageRecordModel) {
        // TODO: Set Icon image
        
        self.lblName.text = model.name
        
        // 库存 & 已售总量
        self.lblSellingCount.text = "\(model.soldCount)"
        self.lblLeftCount.text = "\(model.totalCount - model.soldCount)"
        
        // 售价
        if let price = model.price {
            self.lblSellingPrice.text = String.init(format: "%.2f", price)
        }
        if let cost = model.cost {
            self.lblCostPrice.text = String.init(format: "%.2f", cost)
        }
        
        // format the time,
        let formater = DateFormatter();
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.lblTime.text = formater.string(from: model.time)
    }
    
}
