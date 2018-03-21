//
//  AddStorageViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/19.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCAddStorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(onSaveStorage))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onSaveStorage() {
        // TODO: 数据格式验证 & 保存数据库
        
        self.navigationController?.popViewController(animated: true)
    }

}
