//
//  StorageRecordListViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/14.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class StorageRecordListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrDatasource:[String]?
    
    @IBOutlet weak var tableViewStorageRecords: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
        // TODO: Setup Data
        self.arrDatasource = []
        
        // Setup UI
        self.setupTableview()
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
        NSLog("Add new called")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrDatasource?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "storage_record_cell_identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // TODO: INIT Data
        
        return cell;
        
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("点击到了第\(indexPath.row)行")
    }
}
