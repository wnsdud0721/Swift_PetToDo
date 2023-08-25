//
//  MainTableViewCell.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // Cell 식별자
    // MainTableViewCell 클래스의 인스턴스를 생성하지 않고도 identifier에 접근할 수 있도록 static 사용
    static let identifier = "MainTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Cell에 UILabel 추가
    let memoLabel: UILabel = {
       let label = UILabel()
        label.text = "오늘 할 일"
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkButton: UIButton = {
       let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        button.setImage(UIImage(systemName: "square", withConfiguration: imageConfig), for: .normal)
        button.tintColor = UIColor(named: "MainColor")
        button.configuration = UIButton.Configuration.plain()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func checkButtonTapped() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        if checkButton.isSelected {
            checkButton.setImage(UIImage(systemName: "square", withConfiguration: imageConfig), for: .normal)
            checkButton.isSelected = false
            memoLabel.attributedText = NSAttributedString(string: memoLabel.text ?? "")
        }
        else {
            checkButton.setImage(UIImage(systemName: "checkmark.square.fill", withConfiguration: imageConfig), for: .normal)
            checkButton.isSelected = true
            memoLabel.attributedText = memoLabel.text?.strikeThrough()
        }
    }
    
    // Cell에서 ViewDidLoad()와 같은 기능, 직접 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TableView의 경우, contentView 사용
    func addContentView() {
        contentView.addSubview(checkButton)
        contentView.addSubview(memoLabel)
    }
    
    // Cell 객체 autoLayout
    func autoLayout() {
        let margin: CGFloat = 8
        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            checkButton.widthAnchor.constraint(equalToConstant: 20),
            checkButton.heightAnchor.constraint(equalToConstant: 20),
            
            memoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            memoLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: margin),
            memoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

}
