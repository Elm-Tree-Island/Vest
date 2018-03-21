//
//  MCDatabaseHelper.swift
//  VEST
//
//  Created by Mark on 2018/3/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import SQLite

class MCDatabaseHelper: NSObject {
    
    var dbConnection: Connection!
    
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    override init() {
        super.init()
        self.connectDatabase(filePath:(path+"/db_vest.sqlite3"))
    }
    
    func connectDatabase(filePath: String) -> Void {
        do {
            dbConnection = try Connection(filePath)
            print("Database connect success, DB file path: \(filePath)")
        } catch {
            print("Database connect failed.")
        }
    }
    
    // ==========================================================
    let TABLE_STORAGE = Table("Storage")
    let TABLE_STORAGE_ID = Expression<Int64>("id")
    let TABLE_STORAGE_NAME = Expression<Int64>("name")
    
    let TABLE_STORAGE_COST = Expression<Double>("cost")
    let TABLE_STORAGE_PRICE = Expression<Double>("price")
    let TABLE_STORAGE_OTHER_COST = Expression<Double>("other_cost")
    
    let TABLE_STORAGE_TOTAL_COUNT = Expression<Int64>("total_count")
    let TABLE_STORAGE_SOLD_COUNT = Expression<Int64>("sold_count")
    
    let TABLE_STORAGE_ICON_URL = Expression<String>("icon_url")
    let TABLE_STORAGE_CREATE_TIME = Expression<Date>("create_time")
    
    func createTableStorage() -> Void {
        do {
            try dbConnection.run(TABLE_STORAGE.create { t in
                t.column(TABLE_STORAGE_ID, primaryKey: true)
                t.column(TABLE_STORAGE_NAME)
                
                t.column(TABLE_STORAGE_COST)
                t.column(TABLE_STORAGE_PRICE)
                t.column(TABLE_STORAGE_OTHER_COST)
                
                t.column(TABLE_STORAGE_TOTAL_COUNT)
                t.column(TABLE_STORAGE_SOLD_COUNT)
                
                t.column(TABLE_STORAGE_ICON_URL)
                t.column(TABLE_STORAGE_CREATE_TIME)
            })
        } catch {
            print("Create table storage failed")
        }
    }
}
