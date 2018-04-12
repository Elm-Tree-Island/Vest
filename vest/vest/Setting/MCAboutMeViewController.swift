//
//  MCAboutMeViewController.swift
//  VEST
//
//  Created by Mark on 2018/4/12.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MCAboutMeViewController: MCBaseViewController {
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblVersionBuildNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关于"
        
        self.lblProductName.text = self.getProductName() as String
        self.lblVersionBuildNum.text = "v\(self.getAppVersion()) (Build \(self.getAppBuildNumber()))" as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAppVersion() -> NSString {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? NSString {
            return version
        } else {
            return ""
        }
    }
    
    func getAppBuildNumber() -> NSString {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? NSString {
            return buildNumber
        } else {
            return ""
        }
    }

    func getProductName() -> NSString {
        if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? NSString {
            return name
        } else {
            return ""
        }
    }

}
