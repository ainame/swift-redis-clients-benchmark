import XCTest
@testable import vapor_redis_performance

class vapor_redis_performanceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(vapor_redis_performance().text, "Hello, World!")
    }


    static var allTests: [(String, (vapor_redis_performanceTests) -> () -> Void)] = [
        ("testExample", testExample),
    ]
}
