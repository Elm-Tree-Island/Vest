//
//  MCAddConsumerViewController.swift
//  VEST
//
//  Created by Mark on 2018/5/18.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCAddConsumerViewController: MCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let CELL_IDENTIFIER = "add_consumer_tableview_cell_identifier"
    var consumerModel:MCConsumerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneClicked))

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.consumerModel = MCConsumerModel()
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
        
        MCDatabaseHelper.sharedInstance.insertConsumer(model: self.consumerModel)
        self.navigationController?.popViewController(animated: true)
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
            
        case 1:
            cell.editField.placeholder = "请输入手机号"
            cell.editField.keyboardType = .numberPad
            
        case 2:
            cell.editField.placeholder = "请输入详细地址"
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
