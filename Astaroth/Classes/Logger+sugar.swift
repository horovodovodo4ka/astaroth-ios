//
//  Logger+sugar.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public extension Logger {
    fileprivate func log(_ lazyMessage: @autoclosure @escaping () -> Any, level: LogLevel, type: LogType, trace: StackTraceElement?) {
        log(Lazy(lazyMessage), level: level, type: type, trace)
    }

    func v(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(lazyMessage, level: .verbose, type: type, trace: context)
    }

    func d(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(lazyMessage, level: .debug, type: type, trace: context)
    }

    func i(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(lazyMessage, level: .info, type: type, trace: context)
    }

    func w(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(lazyMessage, level: .warning, type: type, trace: context)
    }

    func e(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(lazyMessage, level: .error, type: type, trace: context)
    }

    func wtf(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(lazyMessage, level: .whatTheFuck, type: type, trace: context)
    }

    func v(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        v(type, lazyMessage, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func d(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        d(type, lazyMessage, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func i(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        i(type, lazyMessage, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func w(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        w(type, lazyMessage, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func e(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        e(type, lazyMessage, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func wtf(_ type: LogType, _ lazyMessage: @autoclosure @escaping () -> Any, file: String = #file, method: String = #function, line: UInt = #line, column: UInt = #column) {
        wtf(type, lazyMessage, StackTraceElement(filename: file, method: method, line: line, column: column))
    }
}
