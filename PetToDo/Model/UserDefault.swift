//
//  UserDefault.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/30.
//

import Foundation

var savedMemos = UserDefaults.standard.stringArray(forKey: "savedMemos") ?? []
