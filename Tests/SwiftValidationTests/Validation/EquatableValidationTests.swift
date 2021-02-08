import Foundation
import XCTest
@testable import SwiftValidation

final class EquatableValidationTests: XCTestCase {
    func testEquatableValidation() {
        XCTAssertNoThrow(
            try validate("hello") {
                equals(to: "hello")
            }
        )

        XCTAssertThrowsError(
            try validateAny("hello") {
                equals(to: "world")
                equals(to: "42")
            }
        )

        XCTAssertNoThrow(
            try validate(4) {
                contains(in: 0..<10)
            }
        )
    }

    private struct Data {
        struct A {
            let a: Int
        }
        struct B {
            let b: Character
        }

        let innerA: A
        let innerB: B
    }

    func testPartialEquatableValidation() {
        let data = Data(innerA: .init(a: 1), innerB: .init(b: "0"))
        XCTAssertNoThrow(
            try validate(data) {
                validateAny(\.innerA.a) {
                    equals(to: 1)
                    equals(to: 0)
                }

                validateAny(\.innerB.b) {
                    equals(to: "1")
                    equals(to: "0")
                }
            }
        )
    }

}
