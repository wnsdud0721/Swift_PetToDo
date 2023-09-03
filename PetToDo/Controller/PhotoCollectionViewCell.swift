//
//  PhotoCollectionViewCell.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/28.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // Cell 식별자
    static let identifier = "PhotoCollectionViewCell"
    
    // Cell에 UIImageView 추가
    let animalImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.lightGray
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
//        NSLayoutConstraint.activate([
//            animalImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
//            animalImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
//            animalImageView.topAnchor.constraint(equalTo: self.topAnchor),
//            animalImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            animalImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            animalImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            animalImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            animalImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
        
        animalImageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
