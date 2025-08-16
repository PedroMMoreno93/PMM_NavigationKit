//
//  ModalItemTests.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 16/8/25.
//

import XCTest
@testable import PMM_NavigationKit

final class ModalItemTests: XCTestCase {

    func test_identifiable_hasUniqueIDs() {
        let m1 = ModalItem(route: "r1")
        let m2 = ModalItem(route: "r1")
        XCTAssertNotEqual(m1.id, m2.id)
    }

    func test_storesAnyHashableRoute() {
        let m = ModalItem(route: "hello")
        XCTAssertEqual(m.route as? String, "hello")
    }

    func test_equatableSemanticsForStoredRoute_whenHashable() {
        let m = ModalItem(route: TestRoute.alpha)
        XCTAssertEqual(m.route as? TestRoute, .alpha)
    }
}

private enum TestRoute: Hashable { case alpha, beta }
