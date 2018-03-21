//
//  StorageRecordModel.swift
//  VEST
//
//  Created by Mark on 2018/3/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import RealmSwift

class MCStorageRecordModel: NSObject {
//    var recordId:NSString                           // 货物ID

    var name:String! = ""                         // 货品名称
    
    var cost:Double? = 0.0                          // 成本价格
    var price:Double? = 0.0                         // 售价
    var otherCost:Double? = 0.0                     // 其他费用
    
    var totalCount:UInt = 0                         // 进货总数
    var soldCount:UInt = 0                          // 已售数量
    
    var picUrl:String! = ""                       // 货物图片
    var time:Date!                                  // 进货时间
    
    override init() {
        super.init()
        
        self.name = ""
        
        self.cost = 0.0
        self.price = 0.0
        self.otherCost = 0.0
        
        self.totalCount = 0
        self.picUrl = ""
        
        self.time = Date()
    }
}
