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
        self.createTableChannel()
        self.createTableConsumer()
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
    
    let TABLE_STORAGE_CATEGORY = Expression<String>("category")
    let TABLE_STORAGE_CHANNEL = Expression<String>("channel")
    
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
                
                t.column(TABLE_STORAGE_CATEGORY)
                t.column(TABLE_STORAGE_CHANNEL)
                
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
            
            recordModel.category = item[TABLE_STORAGE_CATEGORY]
            recordModel.channel = item[TABLE_STORAGE_CHANNEL]
            
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
                                                                  TABLE_STORAGE_CATEGORY <- storageModel.category,
                                                                  TABLE_STORAGE_CHANNEL <- storageModel.channel,
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
        let query = TABLE_CATEGORY.order(TABLE_CATEGORY_NAME.asc)
        let arrResult = NSMutableArray()
        
        for item in (try! dbConnection.prepare(query)) {
            let model = MCCategoryModel()
            model.categoryId = item[TABLE_CATEGORY_ID]
            model.name = item[TABLE_CATEGORY_NAME]

            arrResult.add(model)
        }
        
        return arrResult
    }
    
    func insertCategory(model:MCCategoryModel) -> Bool {
        do {
            let rowID = try dbConnection.run(TABLE_CATEGORY.insert(TABLE_CATEGORY_NAME <- model.name))
            Log.debug?.message("Insert category successfully, new RowId = \(rowID)")
        } catch {
            Log.error?.message("Insert category Failed, category name\(model.name)")
            return false
        }
        return true
    }
    
    func deleteCategory(categoryId:Int64) -> Bool {
        // TODO: 实现
        let recordToDelete = TABLE_CATEGORY.filter(TABLE_CATEGORY_ID == categoryId)
        do {
            try dbConnection.run(recordToDelete.delete())
            Log.debug?.message("Delete category record SUCCESSED, ID = \(categoryId)")
        } catch {
            Log.error?.message("Delete category record FAILED, ID = \(categoryId)")
        }
        
        return true;
    }
    
    // END ===================== Category Table =========================
    
    // ===================== Category Table =========================
    let TABLE_CHANNEL = Table("Channel")
    let TABLE_CHANNEL_ID = Expression<Int64>("id")
    let TABLE_CHANNEL_NAME = Expression<String>("name")
    
    /// Create table 'Storage'
    func createTableChannel() -> Void {
        do {
            try dbConnection.run(TABLE_CHANNEL.create(ifNotExists: true) { t in
                t.column(TABLE_CHANNEL_ID, primaryKey: .autoincrement)
                t.column(TABLE_CHANNEL_NAME)
            })
        } catch {
            Log.error?.message("Create table channel FAILED")
        }
    }
    
    func getAllChannel() -> NSArray {
        let query = TABLE_CHANNEL.order(TABLE_CHANNEL_NAME.asc)
        let arrResult = NSMutableArray()
        
        for item in (try! dbConnection.prepare(query)) {
            let model = MCChannelModel()
            model.channelId = item[TABLE_CHANNEL_ID]
            model.name = item[TABLE_CHANNEL_NAME]
            
            arrResult.add(model)
        }
        
        return arrResult
    }
    
    func insertChannel(model:MCChannelModel) -> Bool {
        do {
            let rowID = try dbConnection.run(TABLE_CHANNEL.insert(TABLE_CHANNEL_NAME <- model.name))
            Log.debug?.message("Insert channel successfully, new RowId = \(rowID)")
        } catch {
            Log.error?.message("Insert channel Failed, category name\(model.name)")
            return false
        }
        return true
    }
    
    func deleteChannel(channelId:Int64) -> Bool {
        // TODO: 实现
        let recordToDelete = TABLE_CHANNEL.filter(TABLE_CHANNEL_ID == channelId)
        do {
            try dbConnection.run(recordToDelete.delete())
            Log.debug?.message("Delete channel record SUCCESSED, ID = \(channelId)")
        } catch {
            Log.error?.message("Delete channel record FAILED, ID = \(channelId)")
        }
        
        return true;
    }
    
    // ===================== Consumer Table =========================
    let TABLE_CONSUMER = Table("Consumer")
    let TABLE_CONSUMER_ID = Expression<Int64>("id")
    let TABLE_CONSUMER_NAME = Expression<String>("name")
    let TABLE_CONSUMER_MOBILE = Expression<String>("mobile")
    let TABLE_CONSUMER_ADDRESS = Expression<String>("address")
    
    /// Create table 'Consumer'
    func createTableConsumer() -> Void {
        do {
            try dbConnection.run(TABLE_CONSUMER.create(ifNotExists: true) { t in
                t.column(TABLE_CONSUMER_ID, primaryKey: .autoincrement)
                t.column(TABLE_CONSUMER_NAME)
                t.column(TABLE_CONSUMER_MOBILE)
                t.column(TABLE_CONSUMER_ADDRESS)
            })
        } catch {
            Log.error?.message("Create table \(TABLE_CONSUMER) FAILED")
        }
    }
    
    func getAllConsumers() -> NSArray {
        let query = TABLE_CONSUMER.order(TABLE_CONSUMER_NAME.asc)
        let arrResult = NSMutableArray()
        
        for item in (try! dbConnection.prepare(query)) {
            let model = MCConsumerModel()
            model.consumerId = item[TABLE_CONSUMER_ID]
            model.name = item[TABLE_CONSUMER_NAME]
            model.mobileNumber = item[TABLE_CONSUMER_MOBILE]
            model.address = item[TABLE_CONSUMER_ADDRESS]
            
            arrResult.add(model)
        }
        
        return arrResult
    }
    
    func insertConsumer(model:MCConsumerModel) -> Bool {
        do {
            let rowID = try dbConnection.run(TABLE_CONSUMER.insert(TABLE_CONSUMER_NAME <- model.name!, TABLE_CONSUMER_MOBILE <- model.mobileNumber!, TABLE_CONSUMER_ADDRESS <- model.address!))
            Log.debug?.message("Insert consumer successfully, new RowId = \(rowID)")
        } catch {
            Log.error?.message("Insert consumer Failed, category name\(model.name!)")
            return false
        }
        return true
    }
    
    func updateConsumer(model:MCConsumerModel) -> Bool {
        do {
            let currentConsumer = TABLE_CONSUMER.filter(TABLE_CONSUMER_ID == model.consumerId)
            
            let rowID = try dbConnection.run(currentConsumer.update(TABLE_CONSUMER_NAME <- model.name!, TABLE_CONSUMER_MOBILE <- model.mobileNumber!, TABLE_CONSUMER_ADDRESS <- model.address!))
            Log.debug?.message("Insert consumer successfully, new RowId = \(rowID)")
        } catch {
            Log.error?.message("Insert consumer Failed, category name\(model.name!)")
            return false
        }
        return true
    }
    
    func deleteConsumer(consumerId:Int64) -> Bool {
        let recordToDelete = TABLE_CONSUMER.filter(TABLE_CONSUMER_ID == consumerId)
        do {
            try dbConnection.run(recordToDelete.delete())
            Log.debug?.message("Delete consumer record SUCCESSED, ID = \(consumerId)")
        } catch {
            Log.error?.message("Delete consumer record FAILED, ID = \(consumerId)")
        }
        
        return true;
    }
}
