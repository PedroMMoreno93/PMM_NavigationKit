import XCTest
@testable import PMM_NavigationKit
import SwiftUI

final class CoordinatorTests: XCTestCase {
    
    //    private var sut: Coordinator!
    //
    //    override func setUp() async throws {
    //        try await super.setUp()
    //        sut = Coordinator()
    //    }
    //
    //    override func tearDown() async throws {
    //        sut = nil
    //        try await super.tearDown()
    //    }
    
    // MARK: - Push / Back / Reset
    
    @MainActor
    func test_show_appendsRouteToPath() async {
        let sut = Coordinator()
        XCTAssertTrue(sut.path.isEmpty)
        sut.show(TestRoute.a)
        XCTAssertFalse(sut.path.isEmpty)
    }
    
    @MainActor
    func test_back_twoPops_makePathEmpty() {
        let sut = Coordinator()
        sut.show(TestRoute.a)
        sut.show(TestRoute.b)
        XCTAssertFalse(sut.path.isEmpty)
        
        sut.back()   // pop b
        XCTAssertFalse(sut.path.isEmpty)
        
        sut.back()   // pop a
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    @MainActor
    func test_back_onEmpty_isNoOp() {
        let sut = Coordinator()
        XCTAssertTrue(sut.path.isEmpty)
        sut.back()   // no crash, still empty
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    @MainActor
    func test_reset_clearsPath() {
        let sut = Coordinator()
        sut.show(TestRoute.a)
        XCTAssertFalse(sut.path.isEmpty)
        sut.popToRoot()
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    // MARK: - Sheet
    
    @MainActor
    func test_presentSheet_setsItem_and_doesNotPrependToPath() {
        let sut = Coordinator()
        XCTAssertNil(sut.sheetItem)
        XCTAssertTrue(sut.sheetPath.isEmpty)
        
        sut.presentSheet(TestSheetRoute.add)
        
        XCTAssertNotNil(sut.sheetItem)
        // Sin "doble root": el path del sheet debe iniciar vacío
        XCTAssertTrue(sut.sheetPath.isEmpty)
    }
    
    @MainActor
    func test_dismissSheet_clearsItem_and_emptiesPath() {
        let sut = Coordinator()
        sut.presentSheet(TestSheetRoute.add)
        sut.dismissSheet()
        XCTAssertNil(sut.sheetItem)
        XCTAssertTrue(sut.sheetPath.isEmpty)
    }
    
    // MARK: - Full Screen Cover
    
    @MainActor
    func test_presentFullCover_setsItem_and_doesNotPrependToPath() {
        let sut = Coordinator()
        XCTAssertNil(sut.fullCoverItem)
        XCTAssertTrue(sut.fullCoverPath.isEmpty)
        
        sut.presentFullCover(TestFullRoute.onboarding)
        
        XCTAssertNotNil(sut.fullCoverItem)
        XCTAssertTrue(sut.fullCoverPath.isEmpty)
    }
    
    @MainActor
    func test_dismissFullCover_clearsItem_and_emptiesPath() {
        let sut = Coordinator()
        sut.presentFullCover(TestFullRoute.onboarding)
        sut.dismissFullCover()
        XCTAssertNil(sut.fullCoverItem)
        XCTAssertTrue(sut.fullCoverPath.isEmpty)
    }
}

// MARK: - Test Routes

private enum TestRoute: Hashable { case a, b }
private enum TestSheetRoute: Hashable { case add }
private enum TestFullRoute: Hashable { case onboarding }
