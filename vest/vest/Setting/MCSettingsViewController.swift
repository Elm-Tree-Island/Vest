//
//  MCSettingsViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCSettingsViewController: MCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var tableviewDatasource:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "更多"

        self.tableviewDatasource = [["类别管理"],
                                    ["隐私声明", "关于"]];
        // Setup UI
        self.setupTableview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI setup
    func setupTableview() {
        self.tableview .register(UITableViewCell.self, forCellReuseIdentifier: "mc_setting_tableview_cell")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.tableviewDatasource?[section] as! NSArray).count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.tableviewDatasource?.count)!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "mc_setting_tableview_cell", for: indexPath)
        let arrRows = self.tableviewDatasource?[indexPath.section] as! NSArray
        cell.textLabel?.text = arrRows[indexPath.row] as? String
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:         // 管理类
            switch indexPath.row {
            case 0:         // 类别管理
                let categoryManageVC = MCCategoryManageViewController()
                self.navigationController?.pushViewController(categoryManageVC, animated: true)

                break
                
            default:
                break
            }
            break
            
        case 1:         // 关于类
            
            break
            
        default:
            // DO NOTHING
            break
        }
    }
}
