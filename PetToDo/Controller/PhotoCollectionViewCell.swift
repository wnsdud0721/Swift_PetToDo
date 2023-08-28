//
//  PhotoCollectionViewCell.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/28.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // Cell 식별자
    static let identifier = "PhotoCollectionViewCell"
    
    // Cell에 UIImageView 추가
    private let animalImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        contentView.addSubview(animalImageView)
    }
    
    // Cell 객체 autoLayout
    private func autoLayout() {
        NSLayoutConstraint.activate([
            animalImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            animalImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            animalImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
