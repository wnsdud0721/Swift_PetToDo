//
//  ViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let createVC = CreateViewController()
    let photoVC = PhotoViewController()
    
    // TableView 만들기
    var mainTableView: UITableView = {
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
        
        configureMainViewUI()
        addMainViewToSubView()
        mainViewAutoLayout()
        mainTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sections 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // TableView 줄 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return savedMemos.count
        }
        return 0
    }
    
    // TableView를 어떻게 보여줄 것인가
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        // Cell 선택 시, 회색 배경 없애기
        mainTableViewCell.selectionStyle = .none
        
        if indexPath.section == 0 {
            
            // 불러오기
            mainTableViewCell.memoLabel.text = savedMemos[indexPath.row]
            
            return mainTableViewCell
        }
        
        return mainTableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "밥 주기"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteMemo = UIContextualAction(style: .normal, title: nil) {
            (action, view, completion) in
            
            // 삭제하기
            savedMemos.remove(at: indexPath.row)
            UserDefaults.standard.set(savedMemos, forKey: "savedMemos")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        deleteMemo.backgroundColor = .systemRed
        deleteMemo.image = UIImage(systemName: "trash.fill")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteMemo])
        
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    // Cell 선택하기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        createVC.editingMemoText = savedMemos[indexPath.row]
        createVC.editingMemoIndex = indexPath.row
        
        createVC.isEditingMode = true

        navigationController?.pushViewController(createVC, animated: true)
    }


}

