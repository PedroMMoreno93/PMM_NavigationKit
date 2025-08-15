//
//  Coordinator.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import SwiftUI

@MainActor
public final class Coordinator: ObservableObject {
    @Published public var path: NavigationPath = .init()
    @Published public var sheetPath: NavigationPath = .init()
    @Published public var fullCoverPath: NavigationPath = .init()

    public var sheetRoute: AnyHashable?
    public var fullCoverRoute: AnyHashable?

    public init() {}

    public func push<R: Hashable>(_ route: R) {
        path.append(route)
    }

    public func presentSheet<R: Hashable>(_ route: R) {
        sheetRoute = route
        sheetPath = NavigationPath()
        sheetPath.append(route)
    }

    public func presentFullCover<R: Hashable>(_ route: R) {
        fullCoverRoute = route
        fullCoverPath = NavigationPath()
        fullCoverPath.append(route)
    }

    public func pop() {
        if !path.isEmpty { path.removeLast() }
    }

    public func dismissSheet() {
        sheetPath = NavigationPath()
        sheetRoute = nil
    }

    public func dismissFullCover() {
        fullCoverPath = NavigationPath()
        fullCoverRoute = nil
    }
}

