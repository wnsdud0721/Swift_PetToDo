//
//  MainTableViewCell.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let image: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(systemName: "square")
        imgView.tintColor = UIColor.systemRed
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "오늘 할 일"
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentView() {
        contentView.addSubview(image)
        contentView.addSubview(label)
    }
    
    func autoLayout() {
        let margin: CGFloat = 8
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

}
