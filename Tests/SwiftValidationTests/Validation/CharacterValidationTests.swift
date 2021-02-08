import Foundation
import XCTest
@testable import SwiftValidation

final class CharacterValidationTests: XCTestCase {
    func testCharacterAlphaNumeric() {
        XCTAssertNoThrow(
            try validate("0") {
                isAlphaNumeric()
                isDecimalDigit()
            }
        )

        XCTAssertThrowsError(
            try validateAny("*") {
                isAlphaNumeric()
                isWhitespace()
            }
        )
    }

    private struct Data {
        struct Inner {
            let character: Character
        }

        let inner: Inner
    }

    func testPartionalCharacterValidation() {
        let alphaNumData =  Data(inner: .init(character: "1"))
        let nonAlphaNumData =  Data(inner: .init(character: " "))
        XCTAssertNoThrow(
            try validate(alphaNumData) {
                validate(\.inner.character).isDecimalDigit().isAlphaNumeric()
            }
        )

        XCTAssertNoThrow(
            try validate(nonAlphaNumData) {
                validateAny(\.inner.character).isWhitespace().isAlphaNumeric()
            }
        )
    }
}
