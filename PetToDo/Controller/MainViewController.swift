//
//  ViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    let createVC = CreateViewController()
    let photoVC = PhotoViewController()
    
    // TableView 만들기
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        // 왼쪽 공백 없애기
        tableView.separatorInset.left = 0
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
    private func configureUI() {
        
        // view 배경색
        view.backgroundColor = .white
        
        // 네비게이션 LargeTitle 활성화 및 title 입력
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.view.tintColor = UIColor(named: "MainColor")
        navigationItem.title = "PetToDo"
        
        let createButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(moveCreateVC))
        
        let photoButton = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle.angled"), style: .plain, target: self, action: #selector(movePhotoVC))
        
        navigationItem.rightBarButtonItems = [ createButton, photoButton ]
        
        // TableView 각 줄 높이
        mainTableView.rowHeight = 44
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    // view에 TableView 추가
    private func addSubView() {
        view.addSubview(mainTableView)
    }
    
    // TableView에 AutoLayout 추가
    private func autoLayout() {
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
        navigationController?.pushViewController(createVC, animated: true)
    }

    // 동물 사진 페이지 이동
    @objc func movePhotoVC() {
        navigationController?.pushViewController(photoVC, animated: true)
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

