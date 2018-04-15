//
//  MCDatabaseHelper.swift
//  VEST
//
//  Created by Mark on 2018/3/21.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import SQLite
import CleanroomLogger

class MCDatabaseHelper: NSObject {
    
    private var dbConnection: Connection!
    
    static let sharedInstance = MCDatabaseHelper()
    
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    private override init() {
        super.init()
        self.connectDatabase(filePath:(path+"/db_vest.sqlite3"))
        
        // Create Table
        self.createTableStorage()
        self.createTableCategory()
    }
    
    private func connectDatabase(filePath: String) -> Void {
        do {
            dbConnection = try Connection(filePath)
            Log.debug?.message("Database connect success, DB file path: \(filePath)")
        } catch {
            Log.error?.message("Database connect failed.")
        }
    }
    
    
    // ===================== Storage Table =========================
    let TABLE_STORAGE = Table("Storage")
    let TABLE_STORAGE_ID = Expression<Int64>("id")
    let TABLE_STORAGE_NAME = Expression<String>("name")
    
    let TABLE_STORAGE_COST = Expression<Double>("cost")
    let TABLE_STORAGE_PRICE = Expression<Double>("price")
    let TABLE_STORAGE_OTHER_COST = Expression<Double>("other_cost")
    
    let TABLE_STORAGE_TOTAL_COUNT = Expression<Int64>("total_count")
    let TABLE_STORAGE_SOLD_COUNT = Expression<Int64>("sold_count")
    
    let TABLE_STORAGE_ICON_URL = Expression<String>("icon_url")
    let TABLE_STORAGE_CREATE_TIME = Expression<Date>("create_time")
    
    
    /// Create table 'Storage'
    func createTableStorage() -> Void {
        do {
            try dbConnection.run(TABLE_STORAGE.create(ifNotExists: true) { t in
                t.column(TABLE_STORAGE_ID, primaryKey: .autoincrement)
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
            Log.error?.message("Create table storage failed")
        }
    }
    
    
    /// Get all the storage record in the database
    ///
    /// - Returns: NSArray<MCStorageRecordModel>
    func getAllStorageRecord() -> NSArray {
        let queryStorage = TABLE_STORAGE.order(TABLE_STORAGE_CREATE_TIME.desc)
        let arrResult = NSMutableArray()
        
        for item in (try! dbConnection.prepare(queryStorage)) {
            let recordModel = MCStorageRecordModel()
            recordModel.recordId = item[TABLE_STORAGE_ID]
            recordModel.name = item[TABLE_STORAGE_NAME]
            
            recordModel.cost = item[TABLE_STORAGE_COST]
            recordModel.price = item[TABLE_STORAGE_PRICE]
            recordModel.otherCost = item[TABLE_STORAGE_OTHER_COST]
            
            recordModel.totalCount = item[TABLE_STORAGE_TOTAL_COUNT]
            recordModel.soldCount = item[TABLE_STORAGE_SOLD_COUNT]
            
            recordModel.picUrl = item[TABLE_STORAGE_ICON_URL]
            recordModel.time = item[TABLE_STORAGE_CREATE_TIME]
            
            arrResult.add(recordModel)
        }
        
        return arrResult
    }
    
    /// Insert an MCStorageRecordModel data to the database
    ///
    /// - Parameter storageModel: MCStorageRecordModel need to save
    /// - Returns: Bool
    func insertStorageRecord(storageModel:MCStorageRecordModel) -> Bool {
        do {
            let rowID = try dbConnection.run(TABLE_STORAGE.insert(TABLE_STORAGE_NAME <- storageModel.name,
                                                                  TABLE_STORAGE_COST <- storageModel.cost!,
                                                                  TABLE_STORAGE_PRICE <- storageModel.price!,
                                                                  TABLE_STORAGE_OTHER_COST <- storageModel.otherCost!,
                                                                  
                                                                  TABLE_STORAGE_TOTAL_COUNT <- storageModel.totalCount,
                                                                  TABLE_STORAGE_SOLD_COUNT <- storageModel.soldCount,
                                                                  
                                                                  TABLE_STORAGE_ICON_URL <- storageModel.picUrl,
                                                                  TABLE_STORAGE_CREATE_TIME <- storageModel.time))
            Log.debug?.message("Insert storage successfully, new RowId = \(rowID)")
        } catch {
            Log.error?.message("Insert storage record Failed, product name\(storageModel.name)")
            return false
        }
        return true
    }
    
    // END ===================== Storage Table =========================
    
    
    // ===================== Category Table =========================
    let TABLE_CATEGORY = Table("Category")
    let TABLE_CATEGORY_ID = Expression<Int64>("id")
    let TABLE_CATEGORY_NAME = Expression<String>("name")

    /// Create table 'Storage'
    func createTableCategory() -> Void {
        do {
            try dbConnection.run(TABLE_CATEGORY.create(ifNotExists: true) { t in
                t.column(TABLE_CATEGORY_ID, primaryKey: .autoincrement)
                t.column(TABLE_CATEGORY_NAME)
            })
        } catch {
            Log.error?.message("Create table category FAILED")
        }
    }
    
    func getAllCategorys() -> NSArray {
        let query = TABLE_CATEGORY.order(TABLE_CATEGORY_NAME.desc)
        let arrResult = NSMutableArray()
        
        for item in (try! dbConnection.prepare(query)) {
            let model = MCCategoryModel()
            model.categoryId = item[TABLE_CATEGORY_ID]
            model.name = item[TABLE_CATEGORY_NAME]

            arrResult.add(model)
        }
        
        return arrResult
    }
    
}
