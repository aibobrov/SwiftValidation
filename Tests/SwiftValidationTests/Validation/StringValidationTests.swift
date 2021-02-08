import Foundation
import XCTest
@testable import SwiftValidation

final class StringValidationTests: XCTestCase {
    func testStringValidation() throws {
        XCTAssertNoThrow(
            try validate("hello123") {
                match(pattern: #"[_a-zA-Z][_a-zA-Z0-9]{0,30}"#)
            }
        )

        XCTAssertNoThrow(
            try validate("_") {
                match(pattern: #"[_a-zA-Z][_a-zA-Z0-9]{0,30}"#)
            }
        )

        XCTAssertThrowsError(
            try validate("13hello") {
                match(pattern: #"[_a-zA-Z][_a-zA-Z0-9]{0,30}"#)
            }
        )

        XCTAssertThrowsError(
            try validate("wow@") {
                isEmail()
            }
        )

        XCTAssertNoThrow(
            try validate("test@example.com") {
                isEmail()
            }
        )

        XCTAssertNoThrow(
            try validate("1996-12-19T16:39:57-08:00") {
                isDate(using: RFC3339DateFormatter)
            }
        )

        XCTAssertNoThrow(
            try validate("02/07/2021") {
                isDate(dateDecodingStrategy: .formatted(simpleDateFormatter))
            }
        )

        let idRegex = try! NSRegularExpression(pattern: #"^[_a-zA-Z][_a-zA-Z0-9]{0,30}$"#, options: .useUnixLineSeparators)
        XCTAssertNoThrow(
            try validate("_hello") {
                match(regex: idRegex)
            }
        )

        XCTAssertThrowsError(
            try validate("12hello") {
                match(regex: idRegex)
            }
        )
    }

    let simpleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    let RFC3339DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
