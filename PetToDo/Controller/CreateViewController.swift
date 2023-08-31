//
//  CreateViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit

class CreateViewController: UIViewController {
    
    static let identifier = "CreateViewController"
    
    var editingMemoText: String?
    
    var editingMemoIndex: Int?
    
    var isTextViewEdited = false
    var isEditingMode = false
    
    let createTextView: UITextView = {
        var textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTextView.delegate = self
        navigationController?.delegate = self
        configureUI()
        addSubView()
        autoLayout()
        configureTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTextView()
    }
    
    // 입력 종료
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.createTextView.resignFirstResponder()
    }
}

extension CreateViewController {
    
    // UI 구성
    private func configureUI() {
        
        // view 배경색
        view.backgroundColor = UIColor.white
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.view.tintColor = UIColor(named: "MainColor")
    }
    
    private func addSubView() {
        view.addSubview(createTextView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            createTextView.topAnchor.constraint(equalTo: self.view.topAnchor),
            createTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            createTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            createTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 16),
            createTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            createTextView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func configureTextView() {
        
        if isEditingMode {
            if let editingMemoText = editingMemoText {
                createTextView.text = editingMemoText
                createTextView.textColor = UIColor.black
            }
            // 네비게이션 바 오른쪽 버튼 커스텀 -> 완료
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishButtonTappedEdit))
        }
        else {
            DispatchQueue.main.async {
                self.createTextView.text = "메모를 작성하세요."
                self.createTextView.textColor = UIColor.lightGray
                self.createTextView.resignFirstResponder()
            }
            // 네비게이션 바 오른쪽 버튼 커스텀 -> 완료
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishButtonTappedNew))
        }
    }
    
    // 메모 내용 수정
    @objc func finishButtonTappedEdit() {
        navigationController?.popViewController(animated: true)
        
        if let updatedMemo = createTextView.text, !updatedMemo.isEmpty,
           let index = editingMemoIndex {
            
            // 해당 인덱스의 내용을 새로운 메모 내용을 수정
            savedMemos[index] = updatedMemo
            UserDefaults.standard.set(savedMemos, forKey: "savedMemos")
            
            // 수정된 메모 내용을 업데이트하고 해당 셀만 리로드
            (self.navigationController?.viewControllers.first as? MainViewController)?.mainTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        isEditingMode = false
    }
    
    // 새로운 메모 작성
    @objc func finishButtonTappedNew() {
        navigationController?.popViewController(animated: true)
        
        if isTextViewEdited {
            
            // savedMemos라는 배열을 불러와서, 추가하기
            savedMemos.append(createTextView.text)
            
            // 추가한 savedMemos를 저장하기
            UserDefaults.standard.set(savedMemos, forKey: "savedMemos")
        }
        
    }
}

extension CreateViewController: UITextViewDelegate {
    
    // 초기 호출
    func textViewDidBeginEditing(_ textView: UITextView) {
        if createTextView.textColor == UIColor.lightGray {
            createTextView.text = nil
            createTextView.textColor = UIColor.black
        }
    }
    
    // 입력 시 호출
    func textViewDidChange(_ textView: UITextView) {
        isTextViewEdited = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        //isTextViewEdited = !createTextView.text.isEmpty
    }
    
    // 입력 종료 시 호출
    func textViewDidEndEditing(_ textView: UITextView) {
        if createTextView.text.isEmpty {
            createTextView.text =  "메모를 작성하세요."
            createTextView.textColor = UIColor.lightGray
        }
    }
}

extension CreateViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if createTextView.text == editingMemoText {
//            isEditingMode = false
//        }
        isEditingMode = false
    }
}
