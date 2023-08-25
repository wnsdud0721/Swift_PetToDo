//
//  Extension_String.swift
//  PetToDo
//
//  Created by Junyoung_Hong on 2023/08/25.
//

import Foundation
import UIKit

// 취소선 생성 함수
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
