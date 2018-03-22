//
//  StorageRecordListViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/14.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

class MCStorageRecordListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrDatasource:NSArray?
    
    @IBOutlet weak var tableViewStorageRecords: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        // Setup UI
        self.setupTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Storage Record"
        
        self.arrDatasource = MCDatabaseHelper.sharedInstance.getAllStorageRecord()
        self.tableViewStorageRecords.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Setup
    func setupTableview() {
        if self.tableViewStorageRecords != nil {
            self.tableViewStorageRecords.delegate = self
            self.tableViewStorageRecords.dataSource = self
            
            self.tableViewStorageRecords.register(UINib.init(nibName: "StorageRecordTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "storage_record_cell_identifier")
        }
    }
    
    // MARK: - Event handling
    
    @objc func addTapped(_ sender: UIBarButtonItem) {
        let addNewVC = MCAddStorageViewController()
        self.navigationController?.pushViewController(addNewVC, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDatasource == nil ? 0 : (self.arrDatasource?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "storage_record_cell_identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // TODO: INIT Data
        let cellStorage = cell as? StorageRecordTableViewCell
        cellStorage?.configWithModel(self.arrDatasource?.object(at: indexPath.row) as! MCStorageRecordModel)
        
        cell.selectionStyle = .none

        return cell;
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MCStorageRecordDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
