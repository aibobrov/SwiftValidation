public func isZero<N: FixedWidthInteger>() -> PredicateValidator<N> {
    equals(to: 0)
}

public extension ExtendableValidator where Element: FixedWidthInteger {
    func isZero() -> Self {
        extended(with: SwiftValidation.isZero())
    }
}

public func isPositive<N: SignedNumeric & BinaryInteger>() -> PredicateValidator<N> {
    check { $0 > 0 }
}

public func isNegative<N: SignedNumeric & BinaryInteger>() -> PredicateValidator<N> {
    check { $0 < 0 }
}

public extension ExtendableValidator where Element: SignedNumeric & BinaryInteger {
    func isPositive() -> Self {
        extended(with: SwiftValidation.isPositive())
    }

    func isNegative() -> Self {
        extended(with: SwiftValidation.isNegative())
    }
}
