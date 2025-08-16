//
//  HomeFlowExampleApp.swift
//  HomeFlowExample
//
//  Created by Pedro M Moreno.
//

import SwiftUI
import PMM_NavigationKit

public struct HomeFlowExampleApp: App {
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
                root:
                    HomeFlow.build(
                        .root(items: items)
                    )
                    .register(
                        HomeRoute.self
                    ) {
                        HomeFlow.build($0)
                    }
            )
            .environmentObject(coordinator)
            .sheet(
                item: $coordinator.sheetItem,
                onDismiss: {
                    coordinator.dismissSheet()
                }
            ) { item in
                NavigationStack(
                    path: $coordinator.sheetPath
                ) {
                    if let route = item.route as? HomeSheetRoute {
                        HomeFlow.buildSheet(route) { item in
                            items.append(item)
                            coordinator.dismissSheet()
                        }
                        .environmentObject(coordinator)
                    } else {
                        Text("Unsupported sheet route")
                    }
                }
            }
            
            .fullScreenCover(
                item: $coordinator.fullCoverItem,
                onDismiss: { coordinator.dismissFullCover()
                }
            ) { item in
                NavigationStack(
                    path: $coordinator.fullCoverPath
                ) {
                    if let route = item.route as? HomeFullCoverRoute {
                        HomeFlow.buildFull(route) { @MainActor in
                            coordinator.dismissFullCover()
                        }
                        .environmentObject(coordinator)
                    } else {
                        Text("Unsupported full cover route")
                    }
                }
                .environmentObject(coordinator)
            }
        }
    }
}
