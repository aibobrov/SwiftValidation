public func isTrue() -> PredicateValidator<Bool> {
    check { $0 }
}

public func isFalse() -> PredicateValidator<Bool> {
    check { !$0 }
}

public extension ExtendableValidator where Element == Bool {
    func isTrue() -> Self {
        extended(with: SwiftValidation.isTrue())
    }

    func isFalse() -> Self {
        extended(with: SwiftValidation.isFalse())
    }
}
