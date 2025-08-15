//
//  RootHostView.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import SwiftUI

public struct RootHostView<Root: View>: View {
    @EnvironmentObject private var coordinator: Coordinator
    private let root: Root

    public init(root: Root) { self.root = root }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            root
            // Features register different destinations with .register(...) from the outside
        }
    }
}
