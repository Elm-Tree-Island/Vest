//
//  MCAddConsumerViewController.swift
//  VEST
//
//  Created by Mark on 2018/5/18.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import SwiftProgressHUD

enum EDIT_MODE {
    case EDIT_MODE_ADD      // 添加新客户
    case EDIT_MODE_EDIT     // 编辑客户信息
}

class MCAddConsumerViewController: MCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let CELL_IDENTIFIER = "add_consumer_tableview_cell_identifier"
    var consumerModel:MCConsumerModel!
    var delegate:MCConsumerManagementDelegate?
    var mode:EDIT_MODE?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneClicked))

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.mode == EDIT_MODE.EDIT_MODE_ADD {
            self.consumerModel = MCConsumerModel()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Init
    func setupTableView() {
        self.tableView.register(UINib(nibName: "MCInputTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - Event Handling
    @objc func onDoneClicked(sender:UIBarButtonItem) {
        let name = (self.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! MCInputTableViewCell).editField.text
        let mobileNumber = (self.tableView.cellForRow(at: IndexPath(item: 1, section: 0)) as! MCInputTableViewCell).editField.text
        let address = (self.tableView.cellForRow(at: IndexPath(item: 2, section: 0)) as! MCInputTableViewCell).editField.text
        
        self.consumerModel.name = (name?.count == 0 ? "" : name)
        self.consumerModel.mobileNumber = (mobileNumber?.count == 0 ? "" : mobileNumber)
        self.consumerModel.address = (address?.count == 0 ? "" : address)
        
        if self.mode == EDIT_MODE.EDIT_MODE_ADD {
            let result = MCDatabaseHelper.sharedInstance.insertConsumer(model: self.consumerModel)
            if result {
                // 插入成功
                SwiftProgressHUD.showSuccess("添加成功", autoClear: true, autoClearTime: 2)
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didAddConsumer(self.consumerModel)
            } else {
                SwiftProgressHUD.showSuccess("添加失败", autoClear: true, autoClearTime: 2)
            }
        } else if self.mode == EDIT_MODE.EDIT_MODE_EDIT {
            // Update the consumer information
            let result = MCDatabaseHelper.sharedInstance.updateConsumer(model: self.consumerModel)
            if result {
                SwiftProgressHUD.showSuccess("更新成功", autoClear: true, autoClearTime: 2)
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didAddConsumer(self.consumerModel)
            } else {
                SwiftProgressHUD.showSuccess("更新失败", autoClear: true, autoClearTime: 2)
            }
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! MCInputTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.editField.placeholder = "请输入姓名"
            if self.mode == EDIT_MODE.EDIT_MODE_EDIT {
                cell.editField.text = self.consumerModel.name
            }
            
        case 1:
            cell.editField.placeholder = "请输入手机号"
            cell.editField.keyboardType = .numberPad
            
            if self.mode == EDIT_MODE.EDIT_MODE_EDIT {
                cell.editField.text = self.consumerModel.mobileNumber
            }
            
        case 2:
            cell.editField.placeholder = "请输入详细地址"
            if self.mode == EDIT_MODE.EDIT_MODE_EDIT {
                cell.editField.text = self.consumerModel.address
            }
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
