//
//  UIImage+extension.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
import UIKit
extension UIImage {
    func crop(to rect: CGRect) -> UIImage? {
        var rect = rect
        rect.size.width *=  self.scale
        rect.size.height *=  self.scale
        guard let imageRef = self.cgImage?.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: imageRef)
    }
}
