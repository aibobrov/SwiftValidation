public func equals<T: Equatable>(to value: T) -> PredicateValidator<T> {
    check { $0 == value }
}

public func contains<T: Equatable, S: Sequence>(in sequence: S) -> PredicateValidator<T> where S.Element == T {
    check { sequence.contains($0) }
}

public extension ExtendableValidator where Element: Equatable {
    func equals(to value: Element) -> Self {
        extended(with: SwiftValidation.equals(to: value))
    }

    func contains<S: Sequence>(in sequence: S) -> Self where S.Element == Element {
        extended(with: SwiftValidation.contains(in: sequence))
    }
}
