//
//  StackTraceElement.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public struct StackTraceElement {
    public let filename: String
    public let method: String
    public let line: UInt
    public let column: UInt

    public init(filename: String, method: String, line: UInt, column: UInt) {
        self.filename = filename
        self.method = method
        self.line = line
        self.column = column
    }

    public static func here(file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) -> StackTraceElement {
        return StackTraceElement(filename: file, method: method, line: line, column: column)
    }
}
