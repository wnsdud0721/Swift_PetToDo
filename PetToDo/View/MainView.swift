//
//  MainView.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/09/05.
//

import Foundation
import UIKit
import SnapKit

extension MainViewController {
    
    // UI 구성
    func configureMainViewUI() {
        
        // view 배경색
        view.backgroundColor = .white
        
        // 네비게이션 LargeTitle 활성화 및 title 입력
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.view.tintColor = UIColor(named: "MainColor")
        navigationItem.title = "PetToDo"
        
        // 네비게이션 오른쪽 버튼 생성
        let createButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(moveCreateVC))
        
        let photoButton = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle.angled"), style: .plain, target: self, action: #selector(movePhotoVC))
        
        navigationItem.rightBarButtonItems = [ createButton, photoButton ]
        
        // TableView 각 줄 높이
        mainTableView.rowHeight = 44
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    // view에 TableView 추가
    func addMainViewToSubView() {
        view.addSubview(mainTableView)
    }
    
    // TableView에 AutoLayout 추가
    func mainViewAutoLayout() {
        
        // Snapkit을 사용한 경우
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    // 메모 생성 페이지 이동
    @objc func moveCreateVC() {
        navigationController?.pushViewController(createVC, animated: true)
    }

    // 동물 사진 페이지 이동
    @objc func movePhotoVC() {
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
