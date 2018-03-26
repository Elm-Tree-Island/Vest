//
//  AddStorageViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/19.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

class MCAddStorageViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ivProductPic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(onSaveStorage))
        
        self.ivProductPic.layer.shadowColor = UIColor(hexString: "#9B9B9B")?.cgColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Setup
    
    
    // MARK: - Event Handling
    @objc func onSaveStorage() {
        // TODO: 数据格式验证 & 保存数据库
        // TEST Data
        let model1 = MCStorageRecordModel()
        model1.price = 1.3
        model1.cost = 1.02
        model1.totalCount = 200
        model1.soldCount = 120
        model1.name = "佑天兰面膜（金色）"
        model1.time = Date()
        
        let insertResult = MCDatabaseHelper.sharedInstance.insertStorageRecord(storageModel: model1)
        if insertResult == true {
            Log.debug?.message("Insert storage record Successed")
        } else {
            Log.debug?.message("Insert storage record FAILED")
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_identifier = "add_cell_identifier_" + String("\(indexPath.row)")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cell_identifier)
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "名称"
                cell?.detailTextLabel?.text = "xxx"
            case 1:
                cell?.textLabel?.text = "分类"
                
            case 2:
                cell?.textLabel?.text = "渠道"
                
            case 3:
                cell?.textLabel?.text = "进价(RMB)"
                
            case 4:
                cell?.textLabel?.text = "数量"
                
            case 5:
                cell?.textLabel?.text = "其他成本(RMB)"
                
            case 6:
                cell?.textLabel?.text = "售价(RMB)"
                
            default:
                cell?.textLabel?.text = "单品毛利(RMB)"
            }
            
            cell?.accessoryType = .disclosureIndicator
            cell?.selectionStyle = .none
        }

        return cell!
    }
}
