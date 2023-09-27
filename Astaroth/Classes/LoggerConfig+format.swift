//
//  LoggerConfig+format.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public extension LoggerConfig {
    func format(_ message: Any, _ traceElement: StackTraceElement?) -> Any {
        var format = self.format

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
