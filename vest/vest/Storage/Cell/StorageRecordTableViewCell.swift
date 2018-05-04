//
//  StorageRecordTableViewCell.swift
//  VEST
//
//  Created by Mark on 2018/3/15.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import Photos

class StorageRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivProductPic: UIImageView!           // 商品图片
    @IBOutlet weak var lblName: UILabel!                    // 商品名称
    
    @IBOutlet weak var lblSellingPrice: UILabel!            // 售价（RMB）
    @IBOutlet weak var lblCostPrice: UILabel!               // 进货价
    
    @IBOutlet weak var lblSellingCount: UILabel!            // 销量
    @IBOutlet weak var lblLeftCount: UILabel!               // 库存量
    
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithModel(_ model:MCStorageRecordModel) {
        // Set Icon image
        self.ivProductPic?.image = self.getImageThumbByLocalID(model.picUrl)
        
        self.lblName.text = model.name
        
        // 库存 & 已售总量
        self.lblSellingCount.text = "\(model.soldCount)"
        self.lblLeftCount.text = "\(model.totalCount - model.soldCount)"
        
        // 售价
        if let price = model.price {
            self.lblSellingPrice.text = String.init(format: "%.2f", price)
        }
        if let cost = model.cost {
            self.lblCostPrice.text = String.init(format: "%.2f", cost)
        }
        
        // format the time,
        let formater = DateFormatter();
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.lblTime.text = formater.string(from: model.time)
    }
    
    // MARK: - 工具方法
    
    /// 通过Image Local ID获取图片文件路径
    ///
    /// - Parameter imageLocalID: String, local image ID
    /// - Returns: String Image file path
    func getImagePathByLocalID(_ imageLocalID:String) -> String? {
        var imagePath:String? = nil
        //通过标志符获取对应的资源
        let assetResult = PHAsset.fetchAssets(withLocalIdentifiers: [imageLocalID], options: nil)
        let asset = assetResult[0]
        let options = PHContentEditingInputRequestOptions()
        options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData)
            -> Bool in
            return true
        }
        //获取保存的图片路径
        asset.requestContentEditingInput(with: options, completionHandler: {
            (contentEditingInput:PHContentEditingInput?, info: [AnyHashable : Any]) in
            imagePath = contentEditingInput!.fullSizeImageURL?.absoluteString
        })
        
        return imagePath
    }
    
    
    /// Get origin image by image local ID
    ///
    /// - Parameter imageLocalID: String Image local ID
    /// - Returns: UIImage
    func getOriginImageByLocalID(_ imageLocalID:String) -> UIImage? {
        var resultImage:UIImage? = nil
        
        //通过标志符获取对应的资源
        let assetResult = PHAsset.fetchAssets(withLocalIdentifiers: [imageLocalID], options: nil)
        let asset = assetResult[0]
        let options = PHContentEditingInputRequestOptions()
        options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData)
            -> Bool in
            return true
        }
        
        //获取保存的原图
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit,
                                              options: nil, resultHandler: { (image, _:[AnyHashable : Any]?) in
                                                resultImage = image
                                                print("获取原图成功")
        })
        
        return resultImage
    }
    
    /// Get origin image thumb by image local ID
    ///
    /// - Parameter imageLocalID: String Image local ID
    /// - Returns: UIImage
    func getImageThumbByLocalID(_ imageLocalID:String) -> UIImage? {
        var resultImage:UIImage? = nil
        
        //通过标志符获取对应的资源
        let assetResult = PHAsset.fetchAssets(withLocalIdentifiers: [imageLocalID], options: nil)
        let asset = assetResult[0]
        let options = PHContentEditingInputRequestOptions()
        options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData)
            -> Bool in
            return true
        }
        //获取保存的缩略图
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width:300, height:300), contentMode: .aspectFit,
                                              options: nil, resultHandler: { (image, _:[AnyHashable : Any]?) in
                                                resultImage = image
        })
        
        return resultImage
    }
    
}
