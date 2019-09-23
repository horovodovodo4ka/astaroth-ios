//
//  Logger.swift
//  Astaroth
//
//  Created by Сидорова Анна Константиновна on 19/09/2019.
//

import Foundation

public enum LogLevel: Int {
    case verbose, debug, info, warning, error, whatTheFuck
}

public protocol LogType: AnyObject {
    var logTag: String { get }
}

public extension LogType {
    var logTag: String {
        return String(describing: type(of: self))
    }
}

public class Lazy<T> {
    private let valueProducer: () -> T
    lazy var value: T = valueProducer()

    fileprivate init(_ producer: @escaping () -> T) {
        self.valueProducer = producer
    }
}

private func lazy<T>(_ producer: @autoclosure @escaping () -> T) -> Lazy<T> {
    return Lazy(producer)
}

private typealias LoggerRecord = (lazyMessage: Lazy<Any>, level: LogLevel, type: LogType)

public struct LoggerConfig {
    public var minimumLevel: LogLevel = .debug
    public var allowedTypes: [LogType] = []
    public var disallowedTypes: [LogType] = []
    /// Formats output with placeholders:
    /// $place - replaced with filename and line where log is called
    /// $context - replaced with call site description (function name etc.)
    /// $message - replaced with message itself
    ///
    /// Default is " $message "
    /// Example: "\n$place @ ($context)\n$message\n"
    public var contextFormat: String?
}

public protocol Logger: AnyObject {
    func log(_ lazyMessage: Lazy<Any>, level: LogLevel, type: LogType)
    var config: LoggerConfig { get set }
}

public extension Logger {
    func isAbleToLog(level: LogLevel, type: LogType) -> Bool {
        if level.rawValue < config.minimumLevel.rawValue { return false }
        if !config.allowedTypes.isEmpty && !config.allowedTypes.contains(where: { type === $0 }) { return false }
        if !config.disallowedTypes.isEmpty && config.disallowedTypes.contains(where: { type === $0 }) { return false }
        return true
    }
}

public struct StackTraceElement {
    public let filename: StaticString
    public let method: StaticString
    public let line: UInt
    public let column: UInt

    public static func here(file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) -> StackTraceElement {
        return StackTraceElement(filename: file, method: method, line: line, column: column)
    }
}

infix operator +=
infix operator -=

public class Log_: Logger {
    fileprivate init() {}

    public var config = LoggerConfig()

    private let queue = DispatchQueue(label: "Log", qos: .default)

    public func log(_ lazyMessage: Lazy<Any>, level: LogLevel, type: LogType) {
        if !isAbleToLog(level: level, type: type) { return }

        queue.async {
            self.loggers.forEach { $0.log(lazyMessage, level: level, type: type) }
        }
    }

    private var loggers: [Logger] = []

    public func addLoggers(_ loggers: Logger...) {
        loggers.forEach { type in
            if !self.loggers.contains(where: { type === $0 }) {
                self.loggers.append(type)
            }
        }
    }

    public func removeLoggers(_ loggers: Logger...) {
        loggers.forEach { type in
            if let idx = self.loggers.firstIndex(where: { type === $0 }) {
                self.loggers.remove(at: idx)
            }
        }
    }

    public func allowType(type: LogType) {
        config.allowedTypes.append(type)
    }

    public func disallowType(type: LogType) {
        config.disallowedTypes.append(type)
    }

    public func log(_ message: @autoclosure @escaping () -> Any, level: LogLevel, type: LogType) {
        log(lazy(message), level: level, type: type)
    }
}

public let Log: Log_ = Log_()

extension LoggerConfig {
    func format(_ message: Any, _ traceElement: StackTraceElement?) -> Any {
        var format = contextFormat ?? " $message "

        format = format.replacingOccurrences(of: "$$", with: "$____$")
        if format.contains("$place") {
            format = format.replacingOccurrences(of: "$place", with: "\(traceElement!.filename):\(traceElement!.line)")
        }
        if format.contains("$context") {
            format = format.replacingOccurrences(of: "$context", with: traceElement != nil ? "\(traceElement!.method)" : "")
        }
        if format.contains("$message") {
            format = format.replacingOccurrences(of: "$message", with: "\(message)")
        }
        format = format.replacingOccurrences(of: "$____$", with: "$")
        return format
    }
}

public extension Logger {
    fileprivate func log(_ message: @autoclosure @escaping () -> Any, level: LogLevel, type: LogType, trace: StackTraceElement?) {
        log(lazy(self.config.format(message(), trace)), level: level, type: type)
    }

    func v(_ type: LogType, _ message: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(message, level: .verbose, type: type, trace: context)
    }

    func d(_ type: LogType, _ message: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(message, level: .debug, type: type, trace: context)
    }

    func i(_ type: LogType, _ message: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(message, level: .info, type: type, trace: context)
    }

    func w(_ type: LogType, _ message: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(message, level: .warning, type: type, trace: context)
    }

    func e(_ type: LogType, _ message: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(message, level: .error, type: type, trace: context)
    }

    func wtf(_ type: LogType, _ message: @autoclosure @escaping () -> Any, _ context: StackTraceElement) {
        log(message, level: .whatTheFuck, type: type, trace: context)
    }

    func v(_ type: LogType, _ message: @autoclosure @escaping () -> Any, file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) {
        v(type, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func d(_ type: LogType, _ message: @autoclosure @escaping () -> Any, file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) {
        d(type, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func i(_ type: LogType, _ message: @autoclosure @escaping () -> Any, file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) {
        i(type, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func w(_ type: LogType, _ message: @autoclosure @escaping () -> Any, file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) {
        w(type, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func e(_ type: LogType, _ message: @autoclosure @escaping () -> Any, file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) {
        e(type, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

    func wtf(_ type: LogType, _ message: @autoclosure @escaping () -> Any, file: StaticString = #file, method: StaticString = #function, line: UInt = #line, column: UInt = #column) {
        wtf(type, message, StackTraceElement(filename: file, method: method, line: line, column: column))
    }

}
