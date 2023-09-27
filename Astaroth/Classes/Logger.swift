//
//  Logger.swift
//  Astaroth
//
//  Created by Сидорова Анна Константиновна on 19/09/2019.
//

import Foundation

public protocol Logger: AnyObject {
    func log(_ lazyMessage: Lazy<Any>, level: LogLevel, type: LogType, _ context: StackTraceElement?)
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

public final class BasicLogger: Logger {
    fileprivate init() {
    }

    public var config = LoggerConfig()

    public func log(_ lazyMessage: Lazy<Any>, level: LogLevel, type: LogType, _ context: StackTraceElement?) {
        if !isAbleToLog(level: level, type: type) { return }

        loggers.forEach { $0.log(lazyMessage, level: level, type: type, context) }
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
}

public let Log: BasicLogger = BasicLogger()
