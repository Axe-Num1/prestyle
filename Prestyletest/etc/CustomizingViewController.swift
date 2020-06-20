////
////  CustomizingViewController.swift
////  Prestyletest
////
////  Created by 강민석 on 2019/11/22.
////  Copyright © 2019 강민석. All rights reserved.
////
//
//import UIKit
//import Foundation
//import Alamofire
//import SwiftyJSON
//
//class CustomizingViewController: UIViewController, FusumaDelegate {
//    
//    var recivedImage: UIImage!
//    
//    @IBOutlet weak var imageView: UIImageView!
//    
//    @IBAction func get(_ sender: Any) {
//        
//        if imageView.image == nil {
//            warningAlert(title: "사진을 활영하거나 앨범에서 선택해주세요!", message: "")
//            return
//        } else {
//            warningAlert(title: "사진을 'Prestyle!'앨범에 저장합니다.", message: "")
//            CustomPhotoAlbum.sharedInstance.saveImage(image: imageView.image!)
//        }
//        
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        showButtonPressed(true)
//
//    }
//    
//    @IBAction func showButtonPressed(_ sender: Any) {
//        // Show Fusuma
//        showFusuma()
//    }
//    
//}
//
//// MARK: - FusumaDelegate Protocol
//extension CustomizingViewController {
//    
//    func showFusuma() {
//        let fusuma = FusumaViewController()
//        
//        fusuma.delegate = self
//        fusuma.cropHeightRatio = 1.0
//        fusuma.allowMultipleSelection = false
//        fusuma.availableModes = [.camera, .library]
//        fusuma.photoSelectionLimit = 2
//        fusumaSavesImage = true
//        
//        present(fusuma, animated: true, completion: nil)
//    }
//    
//    
//    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
//        switch source {
//        case .camera:
//            print("Image captured from Camera")
//        case .library:
//            print("Image selected from Camera Roll")
//        default:
//            print("Image selected")
//        }
//        
//        recivedImage = image
//        imageView.image = image
//    }
//    
//    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
//        print("Number of selection images: \(images.count)")
//        
//        var count: Double = 0
//        
//        for image in images {
//            DispatchQueue.main.asyncAfter(deadline: .now() + (3.0 * count)) {
//                self.recivedImage = image
//                self.imageView.image = image
//                print("w: \(image.size.width) - h: \(image.size.height)")
//            }
//            
//            count += 1
//        }
//    }
//    
//    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
//        print("Image mediatype: \(metaData.mediaType)")
//        print("Source image size: \(metaData.pixelWidth)x\(metaData.pixelHeight)")
//        print("Creation date: \(String(describing: metaData.creationDate))")
//        print("Modification date: \(String(describing: metaData.modificationDate))")
//        print("Video duration: \(metaData.duration)")
//        print("Is favourite: \(metaData.isFavourite)")
//        print("Is hidden: \(metaData.isHidden)")
//        print("Location: \(String(describing: metaData.location))")
//    }
//    
//    func fusumaVideoCompleted(withFileURL fileURL: URL) {
//        print("video completed and output to file: \(fileURL)")
//        //        self.fileUrlLabel.text = "file output to: \(fileURL.absoluteString)"
//    }
//    
//    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
//        switch source {
//        case .camera:
//            print("Called just after dismissed FusumaViewController using Camera")
//            
//        case .library:
//            print("Called just after dismissed FusumaViewController using Camera Roll")
//        default:
//            print("Called just after dismissed FusumaViewController")
//        }
//    }
//    
//    func fusumaCameraRollUnauthorized() {
//        print("Camera roll unauthorized")
//        
//        let alert = UIAlertController(title: "Access Requested",
//                                      message: "Saving image needs to access your photo album",
//                                      preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
//            if let url = URL(string: UIApplication.openSettingsURLString) {
//                UIApplication.shared.openURL(url)
//            }
//        })
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//        })
//        
//        guard let vc = UIApplication.shared.delegate?.window??.rootViewController, let presented = vc.presentedViewController else {
//            return
//        }
//        
//        presented.present(alert, animated: true, completion: nil)
//    }
//    
//    func fusumaClosed() {
//        print("Called when the FusumaViewController disappeared")
//    }
//    
//    func fusumaWillClosed() {
//        print("Called when the close button is pressed")
//    }
//    
//    
//}
//
//
//// MARK: - editView
//extension CustomizingViewController {
//    
//    /*
//    0: bald
//    1: bangs
//    2: black
//    3: brown
//    4: blond
//    */
//    
//    @IBAction func editHair(_ sender: UISegmentedControl) {
//        let data = recivedImage.pngData()
//        switch sender.selectedSegmentIndex {
//        case 0:
//            requestWith(imageData: data, parameters: ["style" : "Bald"])
//        case 1:
//            requestWith(imageData: data, parameters: ["style" : "Bangs"])
//        case 2:
//            requestWith(imageData: data, parameters: ["style" : "Black_Hair"])
//        case 3:
//            requestWith(imageData: data, parameters: ["style" : "Brown_Hair"])
//        case 4:
//            requestWith(imageData: data, parameters: ["style" : "Blond_Hair"])
//        default:
//            return
//        }
//        
//    }
//    
//    /*
//    0: eyebrow
//    1: glass
//    */
//    @IBAction func editEye(_ sender: UISegmentedControl) {
//        let data = recivedImage.pngData()
//        switch sender.selectedSegmentIndex {
//        case 0:
//            requestWith(imageData: data, parameters: ["style" : "Bushy_Eyebrows"])
//        case 1:
//            requestWith(imageData: data, parameters: ["style" : "Eyeglasses"])
//        default:
//            return
//        }
//    }
//    
//    /*
//    0: smile
//    1: beard
//    2: mustache
//    */
//    @IBAction func editMouth(_ sender: UISegmentedControl) {
//        let data = recivedImage.pngData()
//        switch sender.selectedSegmentIndex {
//        case 0:
//            requestWith(imageData: data, parameters: ["style" : "Mouth_Slightly_Open"])
//        case 1:
//            requestWith(imageData: data, parameters: ["style" : "No_Beard"])
//        case 2:
//            requestWith(imageData: data, parameters: ["style" : "Mustache"])
//        default:
//            return
//        }
//    }
//
//    
//}
//
//extension CustomizingViewController {
//        
//        func requestWith(imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//            
//            let url = "http://34.67.247.67:6006/EditFaceAttribute" /* your API url */
//            
//    //        let headers: HTTPHeaders = [
//    //            /* "Authorization": "your_access_token",  in case you need authorization header */
//    //            "Content-type": "multipart/form-data"
//    //        ]
//            
//            self.startIndicatingActivity()
//            Alamofire.upload(multipartFormData: { (multipartFormData) in
//                for (key, value) in parameters {
//                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//                
//                if let data = imageData{
//                    multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//                }
//                
//            }, usingThreshold: UInt64.init(), to: url, method: .post) { (result) in
//                switch result{
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        if let downloadedImage = UIImage(data: response.data!) {
//                            self.imageView.image = downloadedImage
//                        }
//                        self.stopIndicatingActivity()
//                        print("Succesfully uploaded")
//                        if let err = response.error{
//                            onError?(err)
//                            return
//                        }
//                        onCompletion?(nil)
//                    }
//                case .failure(let error):
//                    print("Error in upload: \(error.localizedDescription)")
//                    onError?(error)
//                }
//            }
//        }
//}
