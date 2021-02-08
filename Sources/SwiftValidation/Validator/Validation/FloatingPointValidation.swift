public func equals<N: BinaryFloatingPoint>(_ value: N, delta: N) -> PredicateValidator<N> {
    check { abs($0 - value) <= delta }
}

public func isNan<N: BinaryFloatingPoint>() -> PredicateValidator<N> {
    check { $0.isNaN }
}

public extension ExtendableValidator where Element: BinaryFloatingPoint {
    func equals(_ value: Element, delta: Element) -> Self {
        extended(with: SwiftValidation.equals(value, delta: delta))
    }

    func isNan() -> Self {
        extended(with: SwiftValidation.isNan())
    }
}
