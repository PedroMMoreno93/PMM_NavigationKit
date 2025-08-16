import XCTest
@testable import PMM_NavigationKit
import SwiftUI

final class CoordinatorTests: XCTestCase {
    
    // MARK: - Push / Back / Reset

    @MainActor
    func test_show_appendsRouteToPath() async {
        let sut = Coordinator()
        XCTAssertTrue(sut.path.isEmpty)
        sut.show(TestRoute.alpha)
        XCTAssertFalse(sut.path.isEmpty)
    }
    
    @MainActor
    func test_back_twoPops_makePathEmpty() {
        let sut = Coordinator()
        sut.show(TestRoute.alpha)
        sut.show(TestRoute.beta)
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
        sut.show(TestRoute.alpha)
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
        
        sut.presentSheet(TestSheetRoute.sheetRoute)
        
        XCTAssertNotNil(sut.sheetItem)
        XCTAssertTrue(sut.sheetPath.isEmpty)
    }
    
    @MainActor
    func test_dismissSheet_clearsItem_and_emptiesPath() {
        let sut = Coordinator()
        sut.presentSheet(TestSheetRoute.sheetRoute)
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
        
        sut.presentFullCover(TestFullRoute.fullCoverRoute)
        
        XCTAssertNotNil(sut.fullCoverItem)
        XCTAssertTrue(sut.fullCoverPath.isEmpty)
    }
    
    @MainActor
    func test_dismissFullCover_clearsItem_and_emptiesPath() {
        let sut = Coordinator()
        sut.presentFullCover(TestFullRoute.fullCoverRoute)
        sut.dismissFullCover()
        XCTAssertNil(sut.fullCoverItem)
        XCTAssertTrue(sut.fullCoverPath.isEmpty)
    }
}
