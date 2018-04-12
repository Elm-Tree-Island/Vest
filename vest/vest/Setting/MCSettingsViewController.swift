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

        self.tableviewDatasource = [["类别管理", "渠道管理"],
                                    ["隐私声明", "关于"]];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 12
        } else {
            return 18
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:         // 管理类
            switch indexPath.row {
            case 0:         // 类别管理
                self.navigationController?.pushViewController(MCCategoryManageViewController(), animated: true)
                
            case 1:         // 渠道管理
                self.navigationController?.pushViewController(MCChannelManagementViewController(), animated: true)
                
            default:
                break
            }
            
        case 1:         // 隐私声明、关于
            switch indexPath.row {
            case 0:         // 隐私声明
                self.navigationController?.pushViewController(MCPrivacyViewController(), animated: true)
                break
            case 1:         // 关于
                self.navigationController?.pushViewController(MCAboutMeViewController(), animated: true)
                
            default:
                break
            }
            
        default:
            // DO NOTHING
            break
        }
    }
}
