//
//  CustomPhotoAlbum.swift
//  Prestyletest
//
//  Created by 강민석 on 2019/11/22.
//  Copyright © 2019 강민석. All rights reserved.
//

import Photos
import UIKit


class CustomPhotoAlbum{
    
    
    
    static let albumName = "Prestyle!"
    
    static let sharedInstance = CustomPhotoAlbum()
    
    
    
    var assetCollection: PHAssetCollection!
    
    
    
    init() {
        
        
        
        func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
            
            
            
            let fetchOptions = PHFetchOptions()
            
            fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
            
            let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            
            
            
            if let _: AnyObject = collection.firstObject {
                
                return collection.firstObject! as PHAssetCollection
                
            }
            
            
            
            return nil
            
        }
        
        
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            
            self.assetCollection = assetCollection
            
            return
            
        }
        
        
        
        PHPhotoLibrary.shared().performChanges({
            
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)
            
        }) { success, _ in
            
            if success {
                
                self.assetCollection = fetchAssetCollectionForAlbum()
                
            }
            
        }
        
    }
    
    
    
    func saveImage(image: UIImage) {
        
        
        
        if assetCollection == nil {
            
            return   // If there was an error upstream, skip the save.
            
        }
        
        
        
        PHPhotoLibrary.shared().performChanges({
            
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            
            albumChangeRequest?.addAssets([assetChangeRequest.placeholderForCreatedAsset!] as NSArray)
            
        }, completionHandler: nil)
        
    }
    
    
    
}
