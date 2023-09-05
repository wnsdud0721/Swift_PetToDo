//
//  Extention_UIImage.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/25.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
