//
//  StorageRecordModel.swift
//  VEST
//
//  Created by Mark on 2018/3/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import RealmSwift

class StorageRecordModel: NSObject {
//    var recordId:NSString
    var name:NSString! = ""                         // 货品名称
    
    var cost:Double? = 0.0                          // 成本价格
    var price:Double? = 0.0                         // 售价
    var otherCost:Double? = 0.0                     // 其他费用
    
    var totalCount:UInt = 0                         // 进货总数
    var picUrl:NSString! = ""
    var createTime:NSDate?
    
    override init() {
        super.init()
    }
}
