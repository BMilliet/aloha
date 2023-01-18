import XCTest

enum TestHelper {
    static func compareEnums(expected: [Methods], called: [Methods]) {
        if expected.count == called.count {
            for i in 0..<expected.count {
                XCTAssertEqual(called[i], expected[i])
            }
        } else {
            XCTFail("Number of expected methods different from called methods")
        }
    }
}
