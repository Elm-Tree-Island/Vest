//
//  StorageRecordModel.swift
//  VEST
//
//  Created by Mark on 2018/3/16.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCStorageRecordModel: NSObject {
    var recordId:Int64 = 0                          // 货物ID

    var name:String! = ""                           // 货品名称
    
    var category:String! = ""
    var channel:String! = ""
    
    var cost:Double? = 0.0                          // 成本价格
    var price:Double? = 0.0                         // 售价
    var otherCost:Double? = 0.0                     // 其他费用
    
    var totalCount:Int64 = 0                         // 进货总数
    var soldCount:Int64 = 0                          // 已售数量
    
    var picUrl:String! = ""                         // 货物图片
    var time:Date! = Date()                         // 进货时间
}
