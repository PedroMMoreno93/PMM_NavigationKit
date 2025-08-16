//
//  SmokeCompileTests.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import XCTest
@testable import PMM_NavigationKit
import SwiftUI

final class SmokeCompileTests: XCTestCase {
    
    @MainActor
    func test_rootHostView_compilesWithRegister() {
        // compila: RootHostView + register
        var rootHostView = RootHostView(
            root:
                DummyRootView()
                .register(DummyRoute.self) { route in
                    switch route {
                    case .root:
                        DummyRootView()
                    case .detail(let id):
                        DummyDetailView(id: id)
                    }
                }
        )
    }
    
    @MainActor
    func test_coordinator_lifecycle_compiles() {
        let _ = Coordinator()
    }
}
