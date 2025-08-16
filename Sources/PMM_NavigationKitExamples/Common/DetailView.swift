//
//  DetailView.swift
//  SimpleExample
//
//  Created by Pedro M Moreno.
//

import SwiftUI
import PMM_NavigationKit

public struct DetailView: View {
    @EnvironmentObject private var coordinator: Coordinator
    let item: Item

    public init(
        item: Item
    ) {
        self.item = item
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("Detail").font(.title.bold())
            Text(item.title)
                .font(.footnote)
                .foregroundStyle(.secondary)

            Button("Back") { coordinator.back() }
                .buttonStyle(.bordered)
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
