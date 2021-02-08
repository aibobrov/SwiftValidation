import XCTest
import SwiftValidation
@testable import Example

final class ExampleTests: XCTestCase {
    func testLoadingUser() throws {
        let user = User.loadTestUser()
        XCTAssertNoThrow {
            try validate(user) {
                validate(\.id).isPositive()
                validate(\.name).isNotEmpty()
                validate(\.email) {
                    isNotEmpty()
                    isEmail()
                }
                // is phone number valid
                validate(\.phone).match(pattern: #"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$"#)
                validate(\.dateString).isDate(dateDecodingStrategy: .iso8601)
            }
        }
    }

    static var allTests = [
        ("testExample", testLoadingUser)
    ]
}
