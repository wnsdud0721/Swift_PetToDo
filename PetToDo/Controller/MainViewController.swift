//
//  ViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return tableView
    }()
    
    
    //var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        addSubView()
        autoLayout()
        
        self.mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        self.view.addSubview(tableView)
        
        
    }
}

extension MainViewController {
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "PetToDo"
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.rowHeight = 100
    }
    
    func addSubView() {
        view.addSubview(mainTableView)
    }
    
    func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
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

