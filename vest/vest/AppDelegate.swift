//
//  AppDelegate.swift
//  vest
//
//  Created by Mark on 2018/3/9.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        super.init()
        
        self.setupLogModule()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Log.info?.message("Application did finish launching")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        Log.info?.message("Application will resign active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Log.info?.message("Application did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Log.info?.message("Application will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Log.info?.message("Application did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Log.info?.message("Application will terminate")
    }
    
    // MARK: Init Part
    
    
    /// Setup the CleanroomLogger module
    func setupLogModule() {
        var configs = [LogConfiguration]()
        
        // Xcode config
        let xcodeLogConfig = XcodeLogConfiguration(minimumSeverity: .debug, debugMode: true, verboseDebugMode: false, stdStreamsMode: .useAsFallback, mimicOSLogOutput: true, showCallSite: true, filters: [])
        configs.append(xcodeLogConfig)
        
        // File log config
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileLogCfg = RotatingLogFileConfiguration(minimumSeverity: .debug,
                                                      daysToKeep: 7,
                                                      directoryPath: documentPath + "/CleanroomLogger/")

        do {
            try fileLogCfg.createLogDirectory()
        } catch {
            Log.error?.message("Create Log directory failed")
        }
        
        configs.append(fileLogCfg)
        
        Log.enable(configuration: configs)
    }
    
}

