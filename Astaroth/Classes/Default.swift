//
// Created by Сидорова Анна Константиновна on 19/09/2019.
//

import Foundation

public let Default: LogType = StringTag("+")

public extension Logger {
    func v(_ message: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        v(Default, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func d(_ message: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        d(Default, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func i(_ message: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        i(Default, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func w(_ message: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        w(Default, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func e(_ message: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        e(Default, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func wtf(_ message: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        wtf(Default, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }
}
