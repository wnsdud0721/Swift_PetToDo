//
//  CreateView.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/09/05.
//

import Foundation
import UIKit
import SnapKit

extension CreateViewController {
    
    // UI 구성
    func configureCreateViewUI() {
        
        // view 배경색
        view.backgroundColor = UIColor.white
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.view.tintColor = UIColor(named: "MainColor")
    }
    
    func addCreateViewToSubView() {
        view.addSubview(createTextView)
    }
    
    func createViewAutoLayout() {
        
        createTextView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    func configureCreateTextView() {
        
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
        
        // 수정 모드 종료
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
