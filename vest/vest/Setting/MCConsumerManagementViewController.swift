//
//  MCConsumerManagementViewController.swift
//  VEST
//
//  Created by Mark on 2018/5/15.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

let CELL_IDENTIFIER = "cell_consumer_management_identifier"

protocol MCConsumerManagementDelegate {
    // Add the consumer operation
    func didAddConsumer(_ newConsumer:MCConsumerModel) -> Void
}

class MCConsumerManagementViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource, MCConsumerManagementDelegate {

    @IBOutlet weak var tableview: UITableView!
    var arrDatasource:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "客户管理"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        self.arrDatasource = MCDatabaseHelper.sharedInstance.getAllConsumers()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Event Handling
    @objc func addTapped(_ sender:UIBarButtonItem) {
        let controller = MCAddConsumerViewController()
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UI Init
    func setupTableView() -> Void {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.tableFooterView = UIView()
        
        self.tableview.register(UINib(nibName: "MCConsumerInfoTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! MCConsumerInfoTableViewCell
        
        let model = self.arrDatasource.object(at: indexPath.row) as! MCConsumerModel
        cell.configWithConsumer(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = self.arrDatasource.object(at: indexPath.row) as! MCConsumerModel
            if let consumerId = model.consumerId {
                let result = MCDatabaseHelper.sharedInstance.deleteConsumer(consumerId: consumerId)
                if result {
                    Log.debug?.message("删除用户 - 成功")
                    self.arrDatasource = MCDatabaseHelper.sharedInstance.getAllConsumers()
                    DispatchQueue.main.async {
                        self.tableview.deleteRows(at: [indexPath], with: .automatic)
                    }
                } else {
                    Log.error?.message("删除用户 - 失败")
                    Log.error?.trace()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MCAddConsumerViewController()
        controller.mode = EDIT_MODE.EDIT_MODE_EDIT
        controller.consumerModel = self.arrDatasource.object(at: indexPath.row) as! MCConsumerModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDatasource.count
    }
    
    // MARK: - MCConsumerManagementDelegate
    func didAddConsumer(_ newConsumer:MCConsumerModel) -> Void {
        self.arrDatasource = MCDatabaseHelper.sharedInstance.getAllConsumers()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}
