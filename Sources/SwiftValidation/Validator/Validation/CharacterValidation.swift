#if canImport(Foundation)
import Foundation

func isAlphaNumeric() -> PredicateValidator<Character> {
    check { $0.unicodeScalars.allSatisfy { CharacterSet.alphanumerics.contains($0) } }
}

func isDecimalDigit() -> PredicateValidator<Character> {
    check { $0.unicodeScalars.allSatisfy { CharacterSet.decimalDigits.contains($0) } }
}

func isWhitespace() -> PredicateValidator<Character> {
    check { $0.unicodeScalars.allSatisfy { CharacterSet.whitespaces.contains($0) } }
}

public extension ExtendableValidator where Element == Character {
    func isAlphaNumeric() -> Self {
        extended(with: SwiftValidation.isAlphaNumeric())
    }

    func isDecimalDigit() -> Self {
        extended(with: SwiftValidation.isDecimalDigit())
    }

    func isWhitespace() -> Self {
        extended(with: SwiftValidation.isWhitespace())
    }
}

#endif
