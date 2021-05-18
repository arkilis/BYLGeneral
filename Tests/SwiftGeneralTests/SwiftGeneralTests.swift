import XCTest
import SwiftUI

@testable import SwiftGeneral

final class SwiftGeneralTests: XCTestCase {
  
  
  static var allTests = [
      ("testExample", testExample),
  ]
  
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftGeneral().text, "Hello, World!")
    }
  
}
