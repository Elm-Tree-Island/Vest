//
//  StorageRecordListViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/14.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCStorageRecordListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrDatasource:[MCStorageRecordModel]?
    
    @IBOutlet weak var tableViewStorageRecords: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        // TEST Data
        let model1 = MCStorageRecordModel()
        model1.price = 1.3
        model1.cost = 1.02
        model1.totalCount = 200
        model1.soldCount = 120
        model1.name = "佑天兰面膜（金色）"
        model1.time = Date()
        
        self.arrDatasource = [model1, model1, model1];
        
        // Setup UI
        self.setupTableview()
        
        // FIXME: Test Create Table -> Storage
        let helper = MCDatabaseHelper()
        helper.createTableStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Storage Record"
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
        return (self.arrDatasource?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "storage_record_cell_identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // TODO: INIT Data
        let cellStorage = cell as? StorageRecordTableViewCell
        cellStorage?.configWithModel(self.arrDatasource![indexPath.row])
        
        cell.selectionStyle = .none

        return cell;
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MCStorageRecordDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
