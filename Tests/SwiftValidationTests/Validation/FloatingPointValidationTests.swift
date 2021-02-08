import Foundation
import XCTest
@testable import SwiftValidation

final class FloatingPointValidationTests: XCTestCase {
    func testFloatingValidation() throws {
        XCTAssertNoThrow(
            try validate(1.2) {
                equals(1, delta: 0.5)
            }
        )

        XCTAssertNoThrow(
            try validateAny(Double.nan) {
                isNan()
            }
        )
    }

    private struct Data {
        struct Inner {
            let float: Float
            let double: Double
        }

        let inner: Inner
    }

    func testPartialValidation() {
        let data = Data(inner: .init(float: 1.0, double: 2.0))
        XCTAssertThrowsError(
            try validateAny(data) {
                validate(\.inner.float).isNan()
                validate(\.inner.double).isNan()
            }
        )

        XCTAssertThrowsError(
            try validate(data) {
                validate(\.inner.float).equals(0.5, delta: 0.6)
                validate(\.inner.double).equals(0.5, delta: 0.4)
            }
        )
    }
}
