//
//  Lazy.swift
//  
//
//  Created by Алексей Лысенко on 26.09.2023.
//

import Foundation

public class Lazy<T> {
    private let valueProducer: () -> T
    public private(set) lazy var value: T = valueProducer()

    internal init(_ producer: @escaping () -> T) {
        self.valueProducer = producer
    }
}
