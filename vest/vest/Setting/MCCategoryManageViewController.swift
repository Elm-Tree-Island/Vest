//
//  MCCategoryManageViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

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
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "请输入类别名称"
            
        })
        
        let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
            let strInput = alertController.textFields?.first?.text
            let model = MCCategoryModel()
            if strInput?.isEmpty == false {
                model.name = strInput
                
                let result = MCDatabaseHelper.sharedInstance.insertCategory(model:model)
                if (result) {
                    // 插入成功， 异步更新UI
                    self.arrAllCategoryDataSource = MCDatabaseHelper.sharedInstance.getAllCategorys()
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
        if self.arrAllCategoryDataSource == nil {
            return 0
        } else {
            return self.arrAllCategoryDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: TABLEVIEW_CELL_IDENTIFIER, for: indexPath)
        let category:MCCategoryModel = self.arrAllCategoryDataSource![indexPath.row] as! MCCategoryModel
        
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = "\(category.categoryId)"
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 删除该Cell
            let category = self.arrAllCategoryDataSource![indexPath.row] as! MCCategoryModel
            if category.categoryId > 0 {
                let result = MCDatabaseHelper.sharedInstance.deleteCategory(categoryId: category.categoryId)
                if result {     // 删除成功
                    self.arrAllCategoryDataSource = MCDatabaseHelper.sharedInstance.getAllCategorys()
                    DispatchQueue.main.async {
                        self.tableview.deleteRows(at: [indexPath], with: .automatic)
                    }
                } else {    // 删除失败
                    
                }
            }
            
        }
    }
}
