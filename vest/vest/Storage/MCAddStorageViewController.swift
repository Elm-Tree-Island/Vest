//
//  AddStorageViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/19.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger
import ReactiveCocoa

class MCAddStorageViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var modelToSave:MCStorageRecordModel?
    
    @IBOutlet weak var ivProductPic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"
        
        // Init Data
        self.modelToSave = MCStorageRecordModel()

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
        if self.modelToSave == nil {
            self.modelToSave = MCStorageRecordModel()
        }
        // Save the model
        let insertResult = MCDatabaseHelper.sharedInstance.insertStorageRecord(storageModel: self.modelToSave!)
        if insertResult == true {
            Log.debug?.message("Insert storage record Successed")
        } else {
            Log.debug?.message("Insert storage record FAILED")
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.debug?.message("点击了cell, \(indexPath.row)")
        let cell = tableView.cellForRow(at: indexPath)
        
        switch indexPath.row {
        case 0:     // 名称
            let alertController = UIAlertController(title: "", message: "请输入商品名字", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入商品名称"
                
            })
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.name = strInput
                    cell?.detailTextLabel?.text = strInput
                } else {
                    Log.debug?.message("名字不能为空")
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 1:                 // 分类
            // TODO: 后续添加分类
            break
            
        case 2:                 // 渠道
            // TODO: 选择渠道
            break
            
        case 3:                 // 进货价格
            let alertController = UIAlertController(title: "", message: "请输入进货单价", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入进货单价"
                textField.keyboardType = .decimalPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.cost = Double(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                } else {
                    Log.debug?.message("进货单价不能为空")
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 4:         // 数量
            let alertController = UIAlertController(title: "", message: "请输入数量", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入数量"
                textField.keyboardType = .numberPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.totalCount = Int64(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                } else {
                    Log.debug?.message("数量不能为空")
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 5:         // 其他成本
            let alertController = UIAlertController(title: "", message: "请输入其他成本", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入其他成本"
                textField.keyboardType = .decimalPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.otherCost = Double(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 6:             // 销售单价
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入销售单价"
                textField.keyboardType = .decimalPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.price = Double(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        default:
            break;
        }
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
                cell?.detailTextLabel?.text = self.modelToSave?.name;
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
                let totalCount:Int = Int((self.modelToSave?.totalCount)!)
                var singleGrossProfit:Double = 0
                if totalCount != 0 {
                    let prifitSingle:Double = (self.modelToSave?.price)! - (self.modelToSave?.cost)!;
                    singleGrossProfit = (prifitSingle * Double(totalCount) - (self.modelToSave?.otherCost)!) / Double(totalCount);
                }
                cell?.detailTextLabel?.text = "\(singleGrossProfit)"
            }
            
            cell?.accessoryType = .disclosureIndicator
        }

        return cell!
    }
}
