//
//  MCConsumerManagementViewController.swift
//  VEST
//
//  Created by Mark on 2018/5/15.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

let CELL_IDENTIFIER = "cell_consumer_management_identifier"

class MCConsumerManagementViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var arrDatasource:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "客户管理"

        // Do any additional setup after loading the view.
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Init
    func setupTableView() -> Void {
        self.arrDatasource = ["123"]
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview .register(MCConsumerInfoTableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        
        // TODO: 填充数据
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78;
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDatasource.count
    }
}
