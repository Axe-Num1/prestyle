//
//  test.swift
//  prestyle
//
//  Created by 강민석 on 2019/11/21.
//  Copyright © 2019 강민석. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


class CustomizingViewController: UIViewController, FusumaDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showButtonPressed(true)
    }
    
    @IBAction func showButtonPressed(_ sender: Any) {
        // Show Fusuma
        showFusuma()
    }
    
    
    
    
}

// MARK: - FusumaDelegate Protocol
extension CustomizingViewController {
    
    func showFusuma() {
        let fusuma = FusumaViewController()
        
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusuma.allowMultipleSelection = false
        fusuma.availableModes = [.camera, .library]
        fusuma.photoSelectionLimit = 2
        fusumaSavesImage = true
        
        present(fusuma, animated: true, completion: nil)
    }

    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera:
            print("Image captured from Camera")
        case .library:
            print("Image selected from Camera Roll")
        default:
            print("Image selected")
        }
        imageView.image = image
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        print("Number of selection images: \(images.count)")
        
        var count: Double = 0
        
        for image in images {
            DispatchQueue.main.asyncAfter(deadline: .now() + (3.0 * count)) {
                self.imageView.image = image
                print("w: \(image.size.width) - h: \(image.size.height)")
            }
            
            count += 1
        }
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
        print("Image mediatype: \(metaData.mediaType)")
        print("Source image size: \(metaData.pixelWidth)x\(metaData.pixelHeight)")
        print("Creation date: \(String(describing: metaData.creationDate))")
        print("Modification date: \(String(describing: metaData.modificationDate))")
        print("Video duration: \(metaData.duration)")
        print("Is favourite: \(metaData.isFavourite)")
        print("Is hidden: \(metaData.isHidden)")
        print("Location: \(String(describing: metaData.location))")
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("video completed and output to file: \(fileURL)")
        //        self.fileUrlLabel.text = "file output to: \(fileURL.absoluteString)"
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera:
            print("Called just after dismissed FusumaViewController using Camera")
            
        case .library:
            print("Called just after dismissed FusumaViewController using Camera Roll")
        default:
            print("Called just after dismissed FusumaViewController")
        }
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested",
                                      message: "Saving image needs to access your photo album",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        })
        
        guard let vc = UIApplication.shared.delegate?.window??.rootViewController, let presented = vc.presentedViewController else {
            return
        }
        
        presented.present(alert, animated: true, completion: nil)
    }
    
    func fusumaClosed() {
        print("Called when the FusumaViewController disappeared")
    }
    
    func fusumaWillClosed() {
        print("Called when the close button is pressed")
    }
}


extension CustomizingViewController {
//    
//    Alamofire.request(apiUrl, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
//        switch response.result {
//        case .success(let value):
//            let tempJson = JSON(value)
//            if tempJson["result"].bool! {
//                Toast.long(message: "Current user blocked.", isWarning: false)
//                self.dismissDetail()
//            }
//        case .failure(let error):
//            print(error)
//            Toast.long(message: "Network communication is no working.", isWarning: true)
//        }//end switch
//    })//end responseJSON

}
