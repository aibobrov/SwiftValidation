import Foundation
import XCTest
@testable import SwiftValidation

final class BoolValidation: XCTestCase {
    func testBool() throws {
        XCTAssertThrowsError(
            try validate(false) {
                isTrue()
            }
        )

        XCTAssertThrowsError(
            try validate(true) {
                isFalse()
            }
        )

        XCTAssertNoThrow(
            try validate(false) {
                isFalse()
            }
        )

        XCTAssertNoThrow(
            try validate(true) {
                isTrue()
            }
        )
    }

    private struct Data {
        struct Inner {
            let flag: Bool
        }
        let inner: Inner
    }

    func testPartialValidation() {
        let falseData = Data(inner: .init(flag: false))
        let trueData = Data(inner: .init(flag: true))

        XCTAssertThrowsError(
            try validate(trueData) {
                validate(\.inner.flag) {
                    isFalse()
                }
            }
        )

        XCTAssertThrowsError(
            try validate(falseData) {
                validate(\.inner.flag).isTrue()
            }
        )

        XCTAssertNoThrow(
            try validate(falseData) {
                validate(\.inner.flag).isFalse()
            }
        )

        XCTAssertNoThrow(
            try validate(trueData) {
                validate(\.inner.flag) {
                    isTrue()
                }
            }
        )

    }
}
