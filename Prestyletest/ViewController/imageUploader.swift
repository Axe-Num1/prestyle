//
//  imageUploader.swift
//  Prestyletest
//
//  Created by 강민석 on 2019/11/22.
//  Copyright © 2019 강민석. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class imageUploader {
//    
////    let a = CustomizingViewController()
//    
//    func requestWith(imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//        
//        let url = "http://34.67.247.67:6006/EditFaceAttribute" /* your API url */
//        
////        let headers: HTTPHeaders = [
////            /* "Authorization": "your_access_token",  in case you need authorization header */
////            "Content-type": "multipart/form-data"
////        ]
//        
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            
//            if let data = imageData{
//                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
//            
//        }, usingThreshold: UInt64.init(), to: url, method: .post) { (result) in
//            switch result{
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    if let downloadedImage = UIImage(data: response.data!) {
////                        self.a.imageView.image = downloadedImage
//                    }
//                    print("Succesfully uploaded")
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    onCompletion?(nil)
//                }
//            case .failure(let error):
//                print("Error in upload: \(error.localizedDescription)")
//                onError?(error)
//            }
//        }
//    }
}
