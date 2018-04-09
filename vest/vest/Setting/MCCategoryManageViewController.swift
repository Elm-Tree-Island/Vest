//
//  MCCategoryManageViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCCategoryManageViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "类别管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        self.setupTableview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI setup
    func setupTableview() {
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "mc_setting_tableview_cell")
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.tableFooterView = UIView()
    }

    // MARK: - Event Handler
    @objc func addTapped(_ sender: UIBarButtonItem) {
        
    }

    // MARK: - Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "mc_setting_tableview_cell", for: indexPath)
        cell.textLabel?.text = "arrRows[indexPath.row] as? String"
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
