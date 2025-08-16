//
//  ModalItem.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import Foundation

public struct ModalItem: Identifiable {
    public let id = UUID()
    public let route: AnyHashable
    public init(route: AnyHashable) { self.route = route }
}
