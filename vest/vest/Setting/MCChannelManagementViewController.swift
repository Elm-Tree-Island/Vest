//
//  MCChannelManagementViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/9.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

let TABLEVIEW_CHANNEL_CELL_IDENTIFIER = "mc_setting_tableview_cell_channel"

class MCChannelManagementViewController: MCBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!

    var arrDataSource:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "渠道管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        self.setupTableview()
        
        self.arrDataSource = MCDatabaseHelper.sharedInstance.getAllChannel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI setup
    func setupTableview() {
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: TABLEVIEW_CHANNEL_CELL_IDENTIFIER)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.tableFooterView = UIView()
    }
    
    // MARK: - Event Handler
    @objc func addTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "请输入货源名称"
            
        })
        
        let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
            let strInput = alertController.textFields?.first?.text
            let model = MCChannelModel()
            if strInput?.isEmpty == false {
                model.name = strInput
                
                let result = MCDatabaseHelper.sharedInstance.insertChannel(model:model)
                if (result) {
                    // 插入成功， 异步更新UI
                    self.arrDataSource = MCDatabaseHelper.sharedInstance.getAllChannel()
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
                
            } else {
                Log.debug?.message("名称不能为空")
            }
        })
        
        alertController.addAction(btnCancel)
        alertController.addAction(btnOK)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrDataSource == nil {
            return 0
        } else {
            return self.arrDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: TABLEVIEW_CHANNEL_CELL_IDENTIFIER, for: indexPath)
        
        let channel:MCChannelModel = self.arrDataSource![indexPath.row] as! MCChannelModel

        cell.textLabel?.text = channel.name
        cell.detailTextLabel?.text = "\(channel.channelId)"
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 删除该Cell
            let channelModel = self.arrDataSource![indexPath.row] as! MCChannelModel
            if channelModel.channelId > 0 {
                let result = MCDatabaseHelper.sharedInstance.deleteChannel(channelId: channelModel.channelId)
                if result {     // 删除成功
                    self.arrDataSource = MCDatabaseHelper.sharedInstance.getAllChannel()
                    DispatchQueue.main.async {
                        self.tableview.deleteRows(at: [indexPath], with: .automatic)
                    }
                } else {    // 删除失败
                    
                }
            }
            
        }
    }

}
