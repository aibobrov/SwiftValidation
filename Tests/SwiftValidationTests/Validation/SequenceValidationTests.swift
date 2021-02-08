import Foundation
import XCTest
@testable import SwiftValidation

final class SequenceValidationTests: XCTestCase {
    func testSequenceValidation() {
        XCTAssertNoThrow(
            try validate([0, 2, 4, 8, 16]) {
                isNotEmpty()
                forEach {
                    check { $0 % 2 == 0 }
                    any {
                        isPositive()
                        isZero()
                    }
                }
            }
        )

        XCTAssertThrowsError(
            try validate([-2, 4, 8, 16, 17]) {
                isNotEmpty()
                contains(where: { $0 < 0 })

                forEach {
                    check { $0 % 2 == 0 }
                }
            }
        )
    }

    private struct Data {
        struct Inner {
            let array: [Int]
        }
        let inner: Inner
    }

    func testPartialValidation() {
        let data = Data(inner: .init(array: [1, 2, 3]))
        XCTAssertNoThrow(
            try validate(data) {
                validate(\.inner.array)
                    .forEach(isPositive())
                    .contains(where: { $0 % 2 == 0 })
            }
        )
    }
}
