//
//  AddStorageViewController.swift
//  VEST
//
//  Created by Mark on 2018/3/19.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import CleanroomLogger
import AVFoundation
import CoreActionSheetPicker
import SwiftProgressHUD
import Photos

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}

class MCAddStorageViewController: MCBaseViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var modelToSave:MCStorageRecordModel?
    var imagePickerController:UIImagePickerController!
    var imageLocalID:String?                                // 拍照后图片保存到本地的图片ID，用于查找图片
    
    @IBOutlet weak var ivProductPic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"
        
        // Init Data
        self.modelToSave = MCStorageRecordModel()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(onSaveStorage))
        
        self.setupTableview()
        
        // Elsewhere...
        
        if Platform.isSimulator {
            // Do nothing
        } else {
            self.setupImagePickerCtrler()
        }
        
        // Add gesture recognizer
        self.ivProductPic.layer.shadowColor = UIColor(hexString: "#9B9B9B")?.cgColor
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onTapImageView))
        self.ivProductPic.addGestureRecognizer(tapGR)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Setup
    func setupTableview() {
        if self.tableView != nil {
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    func setupImagePickerCtrler() {
        //    iOS 判断应用是否有使用相机的权限
        let mediaType = AVMediaType.video           //读取媒体类型
        let authStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        if(authStatus == .restricted || authStatus == .denied){
            let errorStr = "应用相机权限受限,请在设置中启用"
            Log.error?.message(errorStr)
            return;
        }
        
        if self.imagePickerController == nil {
            self.imagePickerController = UIImagePickerController()
            self.imagePickerController.delegate = self
            self.imagePickerController.modalTransitionStyle = .flipHorizontal
            self.imagePickerController.sourceType = .camera
        }
    }
    
    // MARK: - Event Handling
    @objc func onSaveStorage() {
        if self.modelToSave == nil {
            self.modelToSave = MCStorageRecordModel()
        }
        // Save the model
        let insertResult = MCDatabaseHelper.sharedInstance.insertStorageRecord(storageModel: self.modelToSave!)
        if insertResult == true {
            Log.debug?.message("Insert storage record Successed")
        } else {
            Log.debug?.message("Insert storage record FAILED")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapImageView() {
        if Platform.isSimulator {       // 模拟器
            SwiftProgressHUD.showOnlyText("模拟器不支持拍照功能")
        } else {        // 真机
            self.navigationController?.present(self.imagePickerController, animated: true, completion: {
            })
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.debug?.message("点击了cell, \(indexPath.row)")
        let cell = tableView.cellForRow(at: indexPath)
        
        switch indexPath.row {
        case 0:     // 名称
            let alertController = UIAlertController(title: "", message: "请输入商品名字", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入商品名称"
                
            })
            
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    cell?.detailTextLabel?.text = strInput
                    self.modelToSave?.name = strInput
                } else {
                    Log.debug?.message("名字不能为空")
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 1:                 // 分类
            let allCategory:NSArray = MCDatabaseHelper.sharedInstance.getAllCategorys()
            let allCategoryName = NSMutableArray()
            
            if allCategory.count == 0 {
                Log.debug?.message("没有类别可选，请在设置页面添加")
                SwiftProgressHUD.showOnlyText("没有类别可选，请在设置页面添加")
            } else {
                // 选择类别
                for model in allCategory {
                    allCategoryName.add((model as! MCCategoryModel).name)
                }
                
                ActionSheetStringPicker.show(withTitle: "选择分类", rows:  allCategoryName as! [Any], initialSelection: (allCategoryName.count / 2), doneBlock: {picker, indexes, values in
                    let categoryName = values as? String
                    cell?.detailTextLabel?.text = categoryName!
                    // 保存类别数据到Model和数据库中
                    self.modelToSave?.category = categoryName
                }, cancel: { ActionMultipleStringCancelBlock in
                    return
                }, origin: cell)
                
            }
            
            break
            
        case 2:                 // 渠道
            let allChannel:NSArray = MCDatabaseHelper.sharedInstance.getAllChannel()
            let allChannelName = NSMutableArray()
            
            if allChannel.count == 0 {
                Log.debug?.message("没有渠道可选，请在设置页面添加")
                // 添加提示
                SwiftProgressHUD.showOnlyText("没有渠道可选，请在设置页面添加")
            } else {
                // 选择渠道
                for model in allChannel {
                    allChannelName.add((model as! MCChannelModel).name)
                }
                
                ActionSheetStringPicker.show(withTitle: "选择渠道", rows:  allChannelName as! [Any], initialSelection: (allChannelName.count / 2), doneBlock: {picker, indexes, values in
                    let channelName = values as? String
                    cell?.detailTextLabel?.text = channelName! as String
                    // 保存渠道数据到Model和数据库中
                    self.modelToSave?.channel = channelName
                }, cancel: { ActionMultipleStringCancelBlock in
                    return
                }, origin: cell)
                
            }
            break
            
        case 3:                 // 进货价格
            let alertController = UIAlertController(title: "", message: "请输入进货单价", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入进货单价"
                textField.keyboardType = .decimalPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.cost = Double(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                } else {
                    Log.debug?.message("进货单价不能为空")
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 4:         // 数量
            let alertController = UIAlertController(title: "", message: "请输入数量", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入数量"
                textField.keyboardType = .numberPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.totalCount = Int64(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                } else {
                    Log.debug?.message("数量不能为空")
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 5:         // 其他成本
            let alertController = UIAlertController(title: "", message: "请输入其他成本", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入其他成本"
                textField.keyboardType = .decimalPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.otherCost = Double(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        case 6:             // 销售单价
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            let btnCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入销售单价"
                textField.keyboardType = .decimalPad
            })
            let btnOK = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                let strInput = alertController.textFields?.first?.text
                
                if strInput?.isEmpty == false {
                    self.modelToSave?.price = Double(strInput!)!
                    cell?.detailTextLabel?.text = strInput
                }
            })
            
            alertController.addAction(btnCancel)
            alertController.addAction(btnOK)
            self.present(alertController, animated: true, completion: nil)
            
        default:
            break;
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_identifier = "add_cell_identifier_" + String("\(indexPath.row)")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cell_identifier)
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "名称"
                cell?.detailTextLabel?.text = self.modelToSave?.name;
            case 1:
                cell?.textLabel?.text = "分类"
                
            case 2:
                cell?.textLabel?.text = "渠道"
                
            case 3:
                cell?.textLabel?.text = "进价(RMB)"
                
            case 4:
                cell?.textLabel?.text = "数量"
                
            case 5:
                cell?.textLabel?.text = "其他成本(RMB)"
                
            case 6:
                cell?.textLabel?.text = "售价(RMB)"
                
            default:
                cell?.textLabel?.text = "单品毛利(RMB)"
                let totalCount:Int = Int((self.modelToSave?.totalCount)!)
                var singleGrossProfit:Double = 0
                if totalCount != 0 {
                    let prifitSingle:Double = (self.modelToSave?.price)! - (self.modelToSave?.cost)!;
                    singleGrossProfit = (prifitSingle * Double(totalCount) - (self.modelToSave?.otherCost)!) / Double(totalCount);
                }
                cell?.detailTextLabel?.text = "\(singleGrossProfit)"
            }
            
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取媒体的类型
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        //如果媒体是照片
        if mediaType == "public.image" as String {
            //获取到拍摄的照片, UIImagePickerControllerEditedImage是经过剪裁过的照片,UIImagePickerControllerOriginalImage是原始的照片
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            //调用方法保存到图像库中
            PHPhotoLibrary.shared().performChanges({
                let result = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let assetPlaceholder = result.placeholderForCreatedAsset
                //保存标志符
                self.imageLocalID = assetPlaceholder?.localIdentifier
            }) { (isSuccess: Bool, error: Error?) in
                if isSuccess {
                    Log.debug?.message("保存图片成功, ID = \(self.imageLocalID ?? "")")

                    // 获取图片ID或URL，保存到Model
                    self.modelToSave?.picUrl = self.imageLocalID
                    // 更新UI
                    DispatchQueue.main.async {
                        self.ivProductPic.image = image
                    }
                } else {
                    Log.error?.message("保存图片失败")
                    SwiftProgressHUD.showFail("保存失败", autoClear: true, autoClearTime: 2)
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
