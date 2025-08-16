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
    let items: [Item]
    
    public init(
        items: [Item]
    ) {
        self.items = items
    }
    
    public var body: some View {
        List {
            Section("Demo actions") {
                Button("➕ Add Item (sheet)") {
                    coordinator.presentSheet(HomeSheetRoute.addItem)
                }
                Button("🚀 Show Onboarding (full-screen)") {
                    coordinator.presentFullCover(HomeFullCoverRoute.onboarding)
                }
                Button("ℹ️ How NavigationKit works") {
                    coordinator.show(HomeRoute.about)
                }
            }
        
            Section("Items") {
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
        }
        .navigationTitle("NavigationKit")
    }
}
