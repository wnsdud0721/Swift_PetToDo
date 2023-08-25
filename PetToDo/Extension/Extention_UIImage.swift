//
//  Extention_UIImage.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/25.
//

import Foundation
import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }

        return resizedImage
    }
}

