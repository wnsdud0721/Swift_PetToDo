//
//  CreateViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit

class CreateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
    }
}

extension CreateViewController {
    
    // UI 구성
    private func configureUI() {
        
        // view 배경색
        view.backgroundColor = UIColor.white
        
        navigationController?.view.tintColor = UIColor(named: "MainColor")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(moveBackMainVC))
    }
    
    @objc func moveBackMainVC() {
        navigationController?.popViewController(animated: true)
    }
}
