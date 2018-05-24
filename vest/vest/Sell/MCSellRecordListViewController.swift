//
//  SellRecordListViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/14.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCSellRecordListViewController: MCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addTapped(_ sender: UIBarButtonItem) {
        let addNewVC = MCAddOrderViewController()
        addNewVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addNewVC, animated: true)
    }
}
