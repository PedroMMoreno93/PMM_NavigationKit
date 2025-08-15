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
    
    public init() {
    }
    
    public var body: some Scene {
        WindowGroup {
            RootHostView(
                root:
                    HomeFlow.build(.root)
                    .register(
                        HomeRoute.self
                    ) {
                        HomeFlow.build($0)
                    }
            )
            .environmentObject(coordinator)
        }
    }
}
