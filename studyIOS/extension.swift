//
//  extension.swift
//  studyIOS
//
//  Created by dhzy on 2026/9/11.
//

import Foundation

extension Int{
    func isZero(_isTrue: () -> Void,_isFalse: () -> Void){
        self == 0 ? _isTrue() : _isFalse()
    }
    
    func max(_ other: Int) -> Int {
        return self > other ? self : other
    }
    
    /// 返回当前值和另一个值中的较小者
    func min(_ other: Int) -> Int {
        return self < other ? self : other
    }
}



extension Optional where Wrapped == String {
    /// 判断可选字符串是否为 nil 或空白（推荐使用）
    var isNilOrEmpty: Bool {
        switch self {
        case.none:
            return true
        case.some(let value):
            return value.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty
        }
    }
    
    /// 判断可选字符串是否有效（非 nil 且非空）
    var isValid: Bool {
        return !isNilOrEmpty
    }
    
}
