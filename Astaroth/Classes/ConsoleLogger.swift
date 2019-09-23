//
// Created by Сидорова Анна Константиновна on 19/09/2019.
//

import Foundation

func errorLevelSign(_ level: LogLevel) -> String {
    switch level {
    case .verbose:
        return "⚪"
    case .debug:
        return "✅"
    case .info:
        return "🔵"
    case .warning:
        return "⚠️"
    case .error:
        return "🆘"
    case .whatTheFuck:
        return "⁉️"
    }
}

public class ConsoleLogger: Logger {
    public init(config: LoggerConfig = LoggerConfig()) {
        self.config = config
    }

    public var levelSign: (LogLevel) -> String = errorLevelSign

    public var config: LoggerConfig

    public func log(_ lazyMessage: Lazy<Any>, level: LogLevel, type: LogType, _ context: StackTraceElement?) {
        if !isAbleToLog(level: level, type: type) { return }

        let tag = type.logTag
        let systemLevel = levelSign(level)
        let message = config.format(lazyMessage.value, context)

        print("\(systemLevel)[\(tag)]\(message)\(systemLevel)")
    }
}