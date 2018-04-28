//
//  StorageItemDetailViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/19.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCStorageRecordDetailViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    public var productModel:MCStorageRecordModel?
    
    @IBOutlet weak var ivProductPic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("详情", comment: "")
    
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.productModel == nil {
            return 0
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_identifier = "add_cell_identifier_" + String("\(indexPath.row)")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cell_identifier)
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "名称"
                cell?.detailTextLabel?.text = self.productModel?.name
            case 1:
                cell?.textLabel?.text = "分类"
                cell?.detailTextLabel?.text = self.productModel?.category
            case 2:
                cell?.textLabel?.text = "渠道"
                cell?.detailTextLabel?.text = self.productModel?.channel
            case 3:
                cell?.textLabel?.text = "进价(RMB)"
                cell?.detailTextLabel?.text = String.init(format: "%.2f", (self.productModel?.cost)!)
            case 4:
                cell?.textLabel?.text = "数量"
                cell?.detailTextLabel?.text = "\(self.productModel?.totalCount ?? 0)"
            case 5:
                cell?.textLabel?.text = "其他成本(RMB)"
                cell?.detailTextLabel?.text = String.init(format: "%.2f", (self.productModel?.otherCost)!)
            case 6:
                cell?.textLabel?.text = "售价(RMB)"
                cell?.detailTextLabel?.text = String.init(format: "%.2f", (self.productModel?.price)!)
            default:
                cell?.textLabel?.text = "单品毛利(RMB)"
                let totalCount:Int = Int((self.productModel?.totalCount)!)
                var singleGrossProfit:Double = 0
                if totalCount != 0 {
                    let prifitSingle:Double = (self.productModel?.price)! - (self.productModel?.cost)!;
                    singleGrossProfit = (prifitSingle * Double(totalCount) - (self.productModel?.otherCost)!) / Double(totalCount);
                }
                cell?.detailTextLabel?.text = String.init(format: "%.2f", singleGrossProfit)
            }
            
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
    }
}
