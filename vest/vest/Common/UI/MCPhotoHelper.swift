//
//  MCPhotoHelper.swift
//  VEST
//
//  Created by Mark on 2018/5/4.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import Photos

class MCPhotoHelper: NSObject {

    
    /// 通过Image Local ID获取图片文件路径
    ///
    /// - Parameter imageLocalID: String, local image ID
    /// - Returns: String Image file path
    class func getImagePathByLocalID(_ imageLocalID:String) -> String? {
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
    class func getOriginImageByLocalID(_ imageLocalID:String) -> UIImage? {
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
                                              targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill,
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
    class func getImageThumbByLocalID(_ imageLocalID:String, rHandler:@escaping ((UIImage?, [AnyHashable : Any]?) -> Swift.Void)) {
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
                                              targetSize: CGSize(width:200, height:200), contentMode: .aspectFill,
                                              options: nil, resultHandler: rHandler)
    }
}
