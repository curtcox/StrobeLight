import XCTest
@testable import StrobeLight

class StrobeLightTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_can_create_view_controller() {
        XCTAssertNotNil(ViewController())
    }

    func test_can_create_view() {
        XCTAssertNotNil(StrobeView())
    }

}
