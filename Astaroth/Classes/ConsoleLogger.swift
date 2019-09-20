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
    public init() {
    }

    public var levelSign: (LogLevel) -> String = errorLevelSign

    public var config = LoggerConfig()

    public func log(_ lazyMessage: Lazy<Any>, level: LogLevel, type: LogType) {
        if !isAbleToLog(level: level, type: type) { return }

        let tag = type.logTag
        let systemLevel = levelSign(level)

        print("\(systemLevel)[\(tag)]\(lazyMessage.value)\(systemLevel)")
    }
}