import Foundation
import XCTest
@testable import SwiftValidation

final class GenericValidationTests: XCTestCase {
    private struct Data {
        let int: Int
        let float: Float
        let string: String
        let character: Character
    }
    func testComplexDataValidation() throws {
        let data = Data(int: 0, float: 1.0, string: "2", character: "3")

        XCTAssertNoThrow(
            try validateAny(data) {}
        )

        XCTAssertNoThrow(
            try validate(data) {
                validate(\.float).equals(1.0, delta: 0.1)
                any {
                    validate(\.int, name: "int") {
                        isPositive()
                        isNegative()
                        check { $0 % 2 == 1 }
                    }
                    validate(\.int, name: "int").isZero()
                }
            }
        )

        XCTAssertThrowsError(
            try validateAny(data) {
                validate(\.int).isPositive()

                all {
                    validate(\.int).isNegative().isZero().check { $0 % 2 == 0 }
                    validate(\.string).isNotEmpty()
                    validate(\.character).isWhitespace()
                }
            }
        )
    }
    private class A {}
    private struct E: Error {}
    private class B: A {
        let e: E
        init(e: E) {
            self.e = e
        }
    }

    func testTypeValidation() {
        let b = B(e: E())
        XCTAssertNoThrow(
            try validate(b as Any) {
                isType(A.self)
                isType(B.self)
            }
        )

        XCTAssertNoThrow(
            try validate(b) {
                validate(\.e).isType(E.self)
            }
        )
    }
}
