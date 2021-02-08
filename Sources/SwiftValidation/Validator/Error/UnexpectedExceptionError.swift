/// Error that occurres when NoThrowValidator's action throws an error.
public struct UnexpectedExceptionError: ValidationError {
    public let reason: Error
}
