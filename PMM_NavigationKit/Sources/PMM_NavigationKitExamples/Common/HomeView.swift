//
//  HomeView.swift
//  SimpleExample
//
//  Created by Pedro M Moreno.
//

import SwiftUI
import PMM_NavigationKit

public struct HomeView: View {
    @EnvironmentObject private var coordinator: Coordinator
    private let items: [Item]
    
    public init(
        items: [Item] = [
            .init(id: UUID(), title: "Element A"),
            .init(id: UUID(), title: "Element B"),
            .init(id: UUID(), title: "Element C")
        ]
    ) {
        self.items = items
    }
    
    public var body: some View {
        List {
            ForEach(items) { item in
                Button {
                    coordinator.show(HomeRoute.detail(item: item))
                } label: {
                    HStack {
                        Image(systemName: "chevron.right.circle")
                        Text(item.title)
                    }
                }
            }
        }
        .navigationTitle("Home")
    }
}
