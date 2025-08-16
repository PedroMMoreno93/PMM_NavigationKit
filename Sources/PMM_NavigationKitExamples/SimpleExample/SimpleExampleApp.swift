//
//  SimpleExample.swift
//  SimpleExample
//
//  Created by Pedro M Moreno.
//

import SwiftUI
import PMM_NavigationKit

public struct SimpleExample: App {
    @StateObject private var coordinator = Coordinator()
    @State private var items: [Item] = [
        .init(title: "Item A"),
        .init(title: "Item B"),
        .init(title: "Item C")
    ]
    
    public init() {
    }
    
    public var body: some Scene {
        WindowGroup {
            RootHostView(
                root: HomeView(items: items)
                    .register(HomeRoute.self) { route in
                        switch route {
                        case .root(let items):
                            HomeView(items: items)
                        case .detail(let item):
                            DetailView(item: item)
                        case .about:
                            AboutView()
                        }
                    }
            )
            .environmentObject(coordinator)
            .sheet(
                item: $coordinator.sheetItem,
                onDismiss: {
                    coordinator.dismissSheet()
                }
            ) { item in
                NavigationStack {
                    if let route = item.route as? HomeSheetRoute {
                        switch route {
                        case .addItem:
                            AddItemView { item in
                                items.append(item)
                            }
                        }
                    } else {
                        Text("Unsupported sheet route")
                    }
                }
            }
            // FULL SCREEN
            .fullScreenCover(
                item: $coordinator.fullCoverItem,
                onDismiss: { coordinator.dismissFullCover()
                }
            ) { item in
                NavigationStack {
                    if let route = item.route as? HomeFullCoverRoute {
                        switch route {
                        case .onboarding:
                            OnboardingView {
                                coordinator.dismissFullCover()
                            }
                        }
                    } else {
                        Text("Unsupported full cover route")
                    }
                }
            }
        }
    }
}
