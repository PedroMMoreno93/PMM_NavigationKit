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

    public init() {
    }
    
    public var body: some Scene {
        WindowGroup {
            RootHostView(
                root: HomeView()
                    .register(HomeRoute.self) { route in
                        switch route {
                        case .root:
                            HomeView()
                        case .detail(let item):
                            DetailView(item: item)
                        }
                    }
            )
                .environmentObject(coordinator)
        }
    }
}
