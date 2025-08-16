//
//  RegisterAndRootHostViewTests.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 16/8/25.
//

import XCTest
@testable import PMM_NavigationKit
import SwiftUI
import UIKit


// MARK: - Test routes

private enum TestRoute: Hashable {
    case root
    case detail(id: Int)
}

// MARK: - Dummy views

private struct DummyRootView: View {
    var body: some View { Text("Root").padding() }
}

private struct DummyDetailView: View {
    let id: Int
    var body: some View { VStack { Text("Detail"); Text("\(id)") } }
}

// MARK: - Recorder (closure-captured)

@MainActor
private final class BuildRecorder {
    var built: [TestRoute] = []
    func record(_ route: TestRoute) { built.append(route) }
}

final class RegisterAndRootHostViewTests: XCTestCase {

    // Host the SwiftUI view in a real UIWindow so NavigationStack/destinations are active.
    @MainActor
    @discardableResult
    private func hostInWindow<V: View>(_ view: V) -> (UIWindow, UIViewController) {
        let vc = UIHostingController(rootView: view)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return (window, vc)
    }

    // Let SwiftUI process updates
    private func spinRunLoop(_ seconds: TimeInterval = 0.3) {
        RunLoop.main.run(until: Date().addingTimeInterval(seconds))
    }

    // ✅ register INSIDE the root passed to RootHostView
    @MainActor
    func test_register_inside_root_builds_destination_on_push() {
        let coordinator = Coordinator()
        let recorder = BuildRecorder()

        let root =
        DummyRootView()
            .register(TestRoute.self) { route in
                switch route {
                case .root:
                    Text("Root Dest")
                        .onAppear {
                            recorder.record(route)
                        }
                case .detail(let id):
                    DummyDetailView(id: id)
                        .onAppear {
                            recorder.record(route)
                        }
                }
            }
        
        let (window, _) = hostInWindow(
            RootHostView(root: root)
                .environmentObject(coordinator)
        )
        
        coordinator.show(TestRoute.detail(id: 7))
        spinRunLoop(0.3)
        
        XCTAssertEqual(recorder.built.last, .detail(id: 7))
        _ = window
    }

    // ❌ register OUTSIDE the root (anti-pattern): should be ignored
    @MainActor
    func test_register_outside_root_does_not_build_destination() {
        let coordinator = Coordinator()
        let recorder = BuildRecorder()

        let outside =
            RootHostView(root: DummyRootView())
                .register(TestRoute.self) { route in
                    switch route {
                    case .root:
                        Text("Root Dest")
                            .onAppear {
                                recorder.record(route)
                            } 

                    case .detail(let id):
                        DummyDetailView(id: id)
                            .onAppear {
                                recorder.record(route)
                            }
                    }
                }
                .environmentObject(coordinator)

        let (window, _) = hostInWindow(outside)

        coordinator.show(TestRoute.detail(id: 42))
        spinRunLoop(0.3)

        XCTAssertTrue(recorder.built.isEmpty, "register applied outside the root must be ignored")
        _ = window
    }

    // 🔁 Multiple registers for different feature routes can coexist
    @MainActor
    func test_multiple_registers_can_coexist() {
        enum A: Hashable { case a1 }
        enum B: Hashable { case b1 }

        let coordinator = Coordinator()
        var builtA = false
        var builtB = false

        let root =
            DummyRootView()
                .register(A.self) { _ in
                    Text("A1")
                        .onAppear {
                            builtA = true
                        }
                }
                .register(B.self) { _ in
                    Text("B1")
                        .onAppear {
                            builtB = true
                        }
                }

        let (window, _) = hostInWindow(
            RootHostView(root: root)
                .environmentObject(coordinator)
        )

        coordinator.show(A.a1)
        spinRunLoop(0.25)
        XCTAssertTrue(builtA)
        XCTAssertFalse(builtB)

        coordinator.show(B.b1)
        spinRunLoop(0.25)
        XCTAssertTrue(builtB)

        _ = window
    }
}
