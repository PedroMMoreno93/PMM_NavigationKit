//
//  TestRoutes.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import Foundation

internal enum DummyRoute: Hashable {
    case root
    case detail(id: Int)
}

internal enum TestRoute: Hashable {
    case alpha
    case beta
}

internal enum TestSheetRoute: Hashable {
    case sheetRoute
}

internal enum TestFullRoute: Hashable {
    case fullCoverRoute
}
