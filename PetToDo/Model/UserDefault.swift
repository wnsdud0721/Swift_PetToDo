//
//  UserDefault.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/30.
//

import Foundation

var savedMemos = UserDefaults.standard.stringArray(forKey: "savedMemos") ?? []

struct MemoItem: Codable {
    var text: String
    var isChecked: Bool
}

var loadedMemoItems: [MemoItem] = []
