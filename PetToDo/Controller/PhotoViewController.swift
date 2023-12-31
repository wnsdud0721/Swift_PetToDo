//
//  PhotoViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit
import SnapKit

class PhotoViewController: UIViewController {
    
    // UIRefreshControl 인스턴스 생성
    let refreshControl = UIRefreshControl()
    
    // CollectionView 만들기
    var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configurePhotoViewUI()
        addPhotoViewToSubView()
        photoViewAutoLayout()
        configureRefreshControl()
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        // 이미지를 가져오려는 URL
        let imageURLString = "https://api.thecatapi.com/v1/images/search?limit=10"
        
        // URLSession을 이용하여 API로부터 데이터를 가져옴
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
                // JSON 데이터를 CatImage 모델로 디코딩
                let images = try JSONDecoder().decode([CatImage].self, from: data)
                
                // 이미지 URL을 가져와 이미지 데이터를 다운로드
                if let firstImageURL = images.first?.url, let imageURL = URL(string: firstImageURL) {
                    URLSession.shared.dataTask(with: imageURL) { imageData, _, _ in
                        if let imageData = imageData, let image = UIImage(data: imageData) {
                            
                            // 다운로드한 이미지를 메인 스레드에서 셀의 이미지 뷰에 할당
                            DispatchQueue.main.async {
                                cell.animalImageView.image = image
                            }
                        }
                    }.resume()
                }
            }
            
            catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
        
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView Cell의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 3)/3, height: (collectionView.bounds.width - 3)/3)
    }
    
    // 수평
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    // 수직
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
}
