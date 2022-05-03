//
//  Tag.swift
//  
//
//  Created by Maxime Maheo on 02/05/2022.
//

import Foundation.NSDate

public struct Tag {
    
    // MARK: - Properties
    
    public let id: UUID
    public let value: String
    public let transactionsCount: Int

    // MARK: - Lifecycle
    
    public init(value: String,
                id: UUID = UUID(),
                transactionsCount: Int? = nil) {
        self.id = id
        self.value = value
        self.transactionsCount = transactionsCount ?? 0
    }
}
