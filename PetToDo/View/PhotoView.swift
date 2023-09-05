//
//  PhotoView.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/09/05.
//

import Foundation
import UIKit
import SnapKit

extension PhotoViewController {
    
    // UI 구성
    func configurePhotoViewUI() {
        
        // view 배경색
        view.backgroundColor = UIColor.white
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.view.tintColor = UIColor(named: "MainColor")
        navigationItem.title = "사진모음"
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    // view에 CollectionView 추가
    func addPhotoViewToSubView() {
        view.addSubview(photoCollectionView)
    }
    
    // CollectionView에 AutoLayout 추가
    func photoViewAutoLayout() {
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // CollectionView에 refreshControl 추가
        photoCollectionView.refreshControl = refreshControl
        
        refreshControl.tintColor = UIColor(named: "CheckColor")
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침", attributes: [.foregroundColor: UIColor(named: "CheckColor")!])
    }
    
    @objc private func refreshData() {
        // API 호출 및 데이터 업데이트 로직을 구현
        fetchNewData()
    }
    
    private func fetchNewData() {
        let imageURLString = "https://api.thecatapi.com/v1/images/search?limit=10"
        
        URLSession.shared.dataTask(with: URL(string: imageURLString)!) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                _ = try JSONDecoder().decode([CatImage].self, from: data)
                
                // 0.7초 딜레이
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    
                    // 새로운 이미지 데이터로 collectionView 갱신
                    self.photoCollectionView.reloadData()
                    
                    // 새로고침 작업 완료 후, 호출
                    self.refreshControl.endRefreshing()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
