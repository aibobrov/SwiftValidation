// Generated using Sourcery 1.1.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

extension BoolValidation {
  static var allTests: [(String, (BoolValidation) -> () throws -> Void)] = [
    ("testBool", testBool),
    ("testPartialValidation", testPartialValidation)
  ]
}
extension CharacterValidationTests {
  static var allTests: [(String, (CharacterValidationTests) -> () throws -> Void)] = [
    ("testCharacterAlphaNumeric", testCharacterAlphaNumeric),
    ("testPartionalCharacterValidation", testPartionalCharacterValidation)
  ]
}
extension CollectionValidationTests {
  static var allTests: [(String, (CollectionValidationTests) -> () throws -> Void)] = [
    ("testCollectionValidation", testCollectionValidation),
    ("testPartialCollectionValidation", testPartialCollectionValidation)
  ]
}
extension EquatableValidationTests {
  static var allTests: [(String, (EquatableValidationTests) -> () throws -> Void)] = [
    ("testEquatableValidation", testEquatableValidation),
    ("testPartialEquatableValidation", testPartialEquatableValidation)
  ]
}
extension FloatingPointValidationTests {
  static var allTests: [(String, (FloatingPointValidationTests) -> () throws -> Void)] = [
    ("testFloatingValidation", testFloatingValidation),
    ("testPartialValidation", testPartialValidation)
  ]
}
extension GenericValidationTests {
  static var allTests: [(String, (GenericValidationTests) -> () throws -> Void)] = [
    ("testComplexDataValidation", testComplexDataValidation),
    ("testTypeValidation", testTypeValidation)
  ]
}
extension IntegerValidationTests {
  static var allTests: [(String, (IntegerValidationTests) -> () throws -> Void)] = [
    ("testIntegerValidation", testIntegerValidation)
  ]
}
extension SequenceValidationTests {
  static var allTests: [(String, (SequenceValidationTests) -> () throws -> Void)] = [
    ("testSequenceValidation", testSequenceValidation),
    ("testPartialValidation", testPartialValidation)
  ]
}
extension StringValidationTests {
  static var allTests: [(String, (StringValidationTests) -> () throws -> Void)] = [
    ("testStringValidation", testStringValidation)
  ]
}

// swiftlint:disable trailing_comma
XCTMain([
  testCase(BoolValidation.allTests),
  testCase(CharacterValidationTests.allTests),
  testCase(CollectionValidationTests.allTests),
  testCase(EquatableValidationTests.allTests),
  testCase(FloatingPointValidationTests.allTests),
  testCase(GenericValidationTests.allTests),
  testCase(IntegerValidationTests.allTests),
  testCase(SequenceValidationTests.allTests),
  testCase(StringValidationTests.allTests),
])
// swiftlint:enable trailing_comma
