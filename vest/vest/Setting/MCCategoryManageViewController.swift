//
//  MCCategoryManageViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCCategoryManageViewController: MCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "类别管理"
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Event Handler
    @objc func addTapped(_ sender: UIBarButtonItem) {
        
    }

}
