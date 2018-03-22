//
//  AddStorageViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/19.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

class MCAddStorageViewController: MCBaseViewController {

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
        // TEST Data
        let model1 = MCStorageRecordModel()
        model1.price = 1.3
        model1.cost = 1.02
        model1.totalCount = 200
        model1.soldCount = 120
        model1.name = "佑天兰面膜（金色）"
        model1.time = Date()
        
        let insertResult = MCDatabaseHelper.sharedInstance.insertStorageRecord(storageModel: model1)
        if insertResult == true {
            Log.debug?.message("Insert storage record Successed")
        } else {
            Log.debug?.message("Insert storage record FAILED")
        }
        
        self.navigationController?.popViewController(animated: true)
    }

}
