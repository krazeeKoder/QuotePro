//
//  UIImageExtension.swift
//  QuotePro
//
//  Created by Anthony Tulai on 2016-02-17.
//  Copyright © 2016 Anthony Tulai. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}