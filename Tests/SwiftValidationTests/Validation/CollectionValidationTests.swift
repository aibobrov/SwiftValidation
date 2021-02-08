import Foundation
import XCTest
@testable import SwiftValidation

final class CollectionValidationTests: XCTestCase {
    func testCollectionValidation() throws {
        XCTAssertThrowsError(
            try validate([1, 2, 3]) {
                isEmpty()
            }
        )

        XCTAssertNoThrow(
            try validateAny([1, 2, 3]) {
                isNotEmpty()
                isEmpty()
            }
        )
    }

    private struct Data {
        let collection: String
    }

    func testPartialCollectionValidation() throws {
        let data = Data(collection: "hello, world")
        XCTAssertThrowsError(
            try validate(data) {
                validate(\.collection).isEmpty()
            }
        )

        XCTAssertThrowsError(
            try validate(data) {
                validate(\.collection).isEmpty()
            }
        )

        XCTAssertNoThrow(
            try validate(data) {
                validate(\.collection).isNotEmpty()
            }
        )
    }
}
