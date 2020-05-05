//
//  ServerManager.swift
//  Prestyletest
//
//  Created by 강민석 on 2020/05/05.
//  Copyright © 2020 강민석. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ServerManager: UIViewController {
    
    func requestWith(imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        let url = "http://34.67.247.67:6006/EditFaceAttribute" /* API url */
        
        //        let headers: HTTPHeaders = [
        //            /* "Authorization": "your_access_token",  in case you need authorization header */
        //            "Content-type": "multipart/form-data"
        //        ]
        
        self.startIndicatingActivity()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData {
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
        }, to: url, usingThreshold: UInt64.init(), method: .post)
            .response { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let downloadedImage = UIImage(data: response.data!) {
                            self.imageView.image = downloadedImage
                        }
                        self.stopIndicatingActivity()
                        print("Succesfully uploaded")
                        if let err = response.error{
                            onError?(err)
                            return
                        }
                        onCompletion?(nil)
                    }
                case .failure(let error):
                    print("Error in upload: \(error.localizedDescription)")
                    onError?(error)
                }
        }
    }
}
