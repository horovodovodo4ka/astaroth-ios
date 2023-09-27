//
//  LoggerConfig.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public struct LoggerConfig {
    public init(minimumLevel: LogLevel = .debug, allowedTypes: [LogType] = [], disallowedTypes: [LogType] = [], format: String = " $message ") {
        self.minimumLevel = minimumLevel
        self.allowedTypes = allowedTypes
        self.disallowedTypes = disallowedTypes
        self.format = format
    }

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
    public var format: String
}
