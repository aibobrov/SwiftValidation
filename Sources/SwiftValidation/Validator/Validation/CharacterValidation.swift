#if canImport(Foundation)
import Foundation

/// Validates that the character is alphabetical and numerical.
func isAlphaNumeric() -> PredicateValidator<Character> {
    check { $0.unicodeScalars.allSatisfy { CharacterSet.alphanumerics.contains($0) } }
}

/// Validates that the character is decimal digit.
func isDecimalDigit() -> PredicateValidator<Character> {
    check { $0.unicodeScalars.allSatisfy { CharacterSet.decimalDigits.contains($0) } }
}

/// Validates that the character is decimal whitespace.
func isWhitespace() -> PredicateValidator<Character> {
    check { $0.unicodeScalars.allSatisfy { CharacterSet.whitespaces.contains($0) } }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element == Character {
    /// Validates that the character is alphabetical and numerical.
    func isAlphaNumeric() -> Self {
        extended(with: SwiftValidation.isAlphaNumeric())
    }

    /// Validates that the character is decimal digit.
    func isDecimalDigit() -> Self {
        extended(with: SwiftValidation.isDecimalDigit())
    }

    /// Validates that the character is decimal whitespace.
    func isWhitespace() -> Self {
        extended(with: SwiftValidation.isWhitespace())
    }
}

#endif
