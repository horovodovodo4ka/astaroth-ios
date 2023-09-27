//
//  NativeLogger.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation
import os

public final class NativeAppleLogger: Astaroth.Logger {
    public var config: LoggerConfig

    public var generateSubsystemId: (String, Astaroth.LogType, OSLogType) -> String = { _, _, _ in Bundle.main.bundleIdentifier! }

    init(config: LoggerConfig = LoggerConfig()) {
        self.config = config
    }

    public func log(_ lazyMessage: Astaroth.Lazy<Any>, level: Astaroth.LogLevel, type: Astaroth.LogType, _ context: Astaroth.StackTraceElement?) {
        let value = lazyMessage.value
        let message = config.format(value, context)

        let log = loggingFunc(for: type, level: logLevel(for: level))
        log("\(message)")
    }

    private func loggingFunc(for type: Astaroth.LogType, level: OSLogType) -> (String) -> Void {
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            return { [generateSubsystemId] message in
                let logger = os.Logger(subsystem: generateSubsystemId(message, type, level), category: type.logTag)
                logger.log(level: level, "\(message, privacy: .public)")
            }
        } else {
            return { [generateSubsystemId] message in
                let logger = OSLog(subsystem: generateSubsystemId(message, type, level), category: type.logTag)
                os_log("%{public}@", log: logger, type: level, "\(message)")
            }
        }
    }

    private func logLevel(for level: Astaroth.LogLevel) -> OSLogType {
        switch level {
        case .whatTheFuck: return .fault
        case .error: return .error
        case .warning: return .error
        case .info: return .info
        case .debug: return .debug
        case .verbose: return .default
        }
    }
}
