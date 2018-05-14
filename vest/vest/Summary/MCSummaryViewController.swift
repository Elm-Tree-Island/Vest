//
//  MCSummaryViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/14.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCSummaryViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var arrTitles:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "统计"

        // Do any additional setup after loading the view.
        self.setupTableview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableview() {
        self.arrTitles = [["总价", "成本", "利润"],
                          ["商品名1", "商品名2", "商品名3"]]
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell_summary_identifier")
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell_summary_identifier", for: indexPath)
        
        let arrRows = self.arrTitles?[indexPath.section] as! NSArray
        cell.textLabel?.text = arrRows[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "整体汇总"
            
        case 1:
            return "库存汇总"
            
        default:
            return ""
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 3
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}
