//
//  EditorViewController.swift
//  Prestyletest
//
//  Created by 강민석 on 2020/05/05.
//  Copyright © 2020 강민석. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    let serverManager = ServerManager()
    var recivedImage: UIImage?
    

    @IBOutlet weak var editImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cameraButtton(_ sender: Any) {
        
    }
    
    @IBAction func galleryButton(_ sender: Any) {
        
    }
    
    
    /*
    0: bald
    1: bangs
    2: black
    3: brown
    4: blond
    */
    
    @IBAction func editHair(_ sender: UISegmentedControl) {
        
        guard let image = editImage.image else {
            
            
            return
        }
        
        let imageData = image.pngData()
        
        switch sender.selectedSegmentIndex {
        case 0:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Bald"])
        case 1:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Bangs"])
        case 2:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Black_Hair"])
        case 3:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Brown_Hair"])
        case 4:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Blond_Hair"])
        default:
            return
        }
        
    }
    
    /*
    0: eyebrow
    1: glass
    */
    @IBAction func editEye(_ sender: UISegmentedControl) {
        
        guard let image = editImage.image else {
            
            return
        }
    
        let imageData = image.pngData()
        
        switch sender.selectedSegmentIndex {
        case 0:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Bushy_Eyebrows"])
        case 1:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Eyeglasses"])
        default:
            return
        }
    }
    
    /*
    0: smile
    1: beard
    2: mustache
    */
    @IBAction func editMouth(_ sender: UISegmentedControl) {
        
        guard let image = editImage.image else {
            
            return
        }
        
        let imageData = image.pngData()
        switch sender.selectedSegmentIndex {
        case 0:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Mouth_Slightly_Open"])
        case 1:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "No_Beard"])
        case 2:
            editImage.image = serverManager.requestWith(imageData: imageData, parameters: ["style" : "Mustache"])
        default:
            return
        }
    }
}
