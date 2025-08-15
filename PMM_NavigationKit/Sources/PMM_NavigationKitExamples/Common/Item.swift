//
//  Item.swift
//  SimpleExample
//
//  Created by Pedro M Moreno.
//

import Foundation

public struct Item: Identifiable, Equatable, Hashable {
    public let id: UUID
    let title: String
    
    public init(
        id: UUID,
        title: String
    ) {
        self.id = id
        self.title = title
    }
}
