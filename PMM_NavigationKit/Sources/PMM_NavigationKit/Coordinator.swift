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

    @Published public var sheetItem: ModalItem? = nil
    @Published public var fullCoverItem: ModalItem? = nil

    public init() {}

    public func show<R: Hashable>(
        _ route: R
    ) {
        path.append(route)
    }
    
    public func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func reset() {
        path = NavigationPath()
    }
    
    public func presentSheet<R: Hashable>(_ route: R) {
        sheetItem = ModalItem(route: route)
        sheetPath = NavigationPath()
        sheetPath.append(route)
    }

    public func presentFullCover<R: Hashable>(_ route: R) {
        fullCoverItem = ModalItem(route: route)
        fullCoverPath = NavigationPath()
        fullCoverPath.append(route)
    }

    public func dismissSheet() {
        sheetPath = NavigationPath()
        sheetItem = nil
    }

    public func dismissFullCover() {
        fullCoverPath = NavigationPath()
        fullCoverItem = nil
    }
}

