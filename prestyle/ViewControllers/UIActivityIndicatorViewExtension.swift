//
//  UIActivityIndicatorViewExtension.swift
//  prestyle
//
//  Created by 강민석 on 2019/11/21.
//  Copyright © 2019 강민석. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        indicator.layer.cornerRadius = 15
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.white
        indicator.backgroundColor = UIColor(red: 0.96, green: 0.54, blue: 0.1, alpha: 1.0)
        return indicator
    }
}
