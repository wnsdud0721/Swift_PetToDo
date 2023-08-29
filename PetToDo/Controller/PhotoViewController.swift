//
//  PhotoViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit

class PhotoViewController: UIViewController {
    
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
        
        configureUI()
        addSubView()
        autoLayout()
    }
}

extension PhotoViewController {
    
    // UI 구성
    private func configureUI() {
        
        // view 배경색
        view.backgroundColor = UIColor.white
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.view.tintColor = UIColor(named: "MainColor")
        navigationItem.title = "사진모음"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(moveBackMainVC))
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    @objc func moveBackMainVC() {
        navigationController?.popViewController(animated: true)
    }
    
    // view에 CollectionView 추가
    private func addSubView() {
        view.addSubview(photoCollectionView)
    }
    
    // CollectionView에 AutoLayout 추가
    private func autoLayout() {
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            photoCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            photoCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
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
