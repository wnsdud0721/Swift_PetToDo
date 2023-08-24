//
//  ViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    // TableView 만들기
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        addSubView()
        autoLayout()
    }
}

extension MainViewController {
    
    // UI 구성
    func configureUI() {
        
        // view 배경색
        view.backgroundColor = .white
        
        // 네비게이션 LargeTitle 활성화 및 title 입력
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "PetToDo"
        
        let createButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(moveCreateVC))
        createButton.tintColor = UIColor(named: "MainColor")
        
        let photoButton = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle.angled"), style: .plain, target: self, action: #selector(movePhotoVC))
        photoButton.tintColor = UIColor(named: "MainColor")
        
        navigationItem.rightBarButtonItems = [ createButton, photoButton ]
        
        // TableView 각 줄 높이
        mainTableView.rowHeight = 45
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    // view에 TableView 추가
    func addSubView() {
        view.addSubview(mainTableView)
    }
    
    // TableView에 AutoLayout 추가
    func autoLayout() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainTableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    // 메모 생성 페이지 이동
    @objc func moveCreateVC() {
        CreateViewController()
        guard let moveCreateVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateViewController") as? CreateViewController else { return }
        navigationController?.pushViewController(moveCreateVC, animated: true)
        print("test")
    }

    // 동물 사진 페이지 이동
    @objc func movePhotoVC() {
        guard let movePhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
        navigationController?.pushViewController(movePhotoVC, animated: true)
        print("test")
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        return mainTableViewCell
    }


}

