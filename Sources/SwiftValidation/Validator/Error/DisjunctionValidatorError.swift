/// Error that collects all errors of the validators occured when validating using disjunction validation strategy.
public struct DisjunctionValidatorError: ValidationError {
    public let errors: [Error]
}
