import XCTest
@testable import GenericAppInitializer

final class GenericAppInitializerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GenericAppInitializer().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
