//
//  UIImageView+extension.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 09/06/2023.
//

import Foundation
import UIKit
extension UIImageView {
    func downloaded(from url: URL,
                    contentMode mode: ContentMode = .scaleAspectFit,
                    completion: @escaping (UIImage) -> Void ) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                let size  = image.size
                let cropImage = image.crop(to: CGRect(x: 0, y: 100, width: size.width, height: size.height/2))

                self?.image = cropImage
                completion(image)
            }
        }.resume()
    }
    func downloadedCrop(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url) { image in
            DispatchQueue.main.async { [weak self] in
                let size  = image.size
                let cropImage = image.crop(to: CGRect(x: 0, y: 100, width: size.width, height: size.height/2))
                self?.image = cropImage
            }
        }
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url) { image in
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
}
