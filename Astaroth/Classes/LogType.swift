//
//  LogType.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public protocol LogType: AnyObject {
    var logTag: String { get }
}

public extension LogType {
    var logTag: String {
        String(describing: type(of: self))
    }
}
