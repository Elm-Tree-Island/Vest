//
//  MCCategoryManageViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

let TABLEVIEW_CELL_IDENTIFIER = "mc_setting_category_tableview_cell"

class MCCategoryManageViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    var arrAllCategoryDataSource:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "类别管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        self.setupTableview()
        
        self.arrAllCategoryDataSource = MCDatabaseHelper.sharedInstance.getAllCategorys()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI setup
    func setupTableview() {
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: TABLEVIEW_CELL_IDENTIFIER)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.tableFooterView = UIView()
    }
    
    // MARK: - Event Handler
    @objc func addTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrAllCategoryDataSource == nil {
            return 0
        } else {
            return self.arrAllCategoryDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: TABLEVIEW_CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = "arrRows[indexPath.row] as? String"
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
