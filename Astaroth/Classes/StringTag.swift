//
//  StringTag.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public class StringTag : LogType {
    public let logTag : String

    public init(_ tag: String) {
        self.logTag = tag
    }
}
