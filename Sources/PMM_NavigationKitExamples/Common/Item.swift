//
//  Item.swift
//  SimpleExample
//
//  Created by Pedro M Moreno.
//

import Foundation

public struct Item: Identifiable, Equatable, Hashable {
    public let id: UUID = UUID()
    let title: String
    
    public init(
        title: String
    ) {
        self.title = title
    }
}
