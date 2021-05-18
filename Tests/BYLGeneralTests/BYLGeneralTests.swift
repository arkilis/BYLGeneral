import XCTest
@testable import BYLGeneral

final class BYLGeneralTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BYLGeneral().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
