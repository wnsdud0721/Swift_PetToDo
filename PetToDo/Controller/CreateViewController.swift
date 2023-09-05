//
//  CreateViewController.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/24.
//

import UIKit
import SnapKit

class CreateViewController: UIViewController {
    
    static let identifier = "CreateViewController"
    
    var editingMemoText: String?
    
    var editingMemoIndex: Int?
    
    var isTextViewEdited = false
    var isEditingMode = false
    
    // TextView 생성
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
        configureCreateViewUI()
        addCreateViewToSubView()
        createViewAutoLayout()
        configureCreateTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCreateTextView()
    }
    
    // 입력 종료
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.createTextView.resignFirstResponder()
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
        isEditingMode = false
    }
}
