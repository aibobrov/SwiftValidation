import Foundation
import XCTest
@testable import SwiftValidation

final class IntegerValidationTests: XCTestCase {
    func testIntegerValidation() throws {
        XCTAssertNoThrow(
            try validate(3) {
                isPositive()
                check { $0 % 2 == 1 }
            }
        )

        XCTAssertThrowsError(
            try validateAny(-1) {
                isPositive()
                check { $0 % 2 == 0 }
            }
        )
    }
}
