public func match(pattern: String) -> PredicateValidator<String> {
    check { $0.range(of: pattern, options: [.regularExpression, .anchored]) != nil }
}

public func isEmail() -> PredicateValidator<String> {
    match(
        pattern: #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"# // swiftlint:disable:this line_length
    )
}

public extension ExtendableValidator where Element == String {
    func match(pattern: String) -> Self {
        extended(with: SwiftValidation.match(pattern: pattern))
    }

    func isEmail() -> Self {
        extended(with: SwiftValidation.isEmail())
    }
}

#if canImport(Foundation)
import Foundation

public func match(regex: NSRegularExpression) -> PredicateValidator<String> {
    check {
        !regex.matches(in: $0, options: [], range: NSRange(location: 0, length: $0.count)).isEmpty
    }
}

public func isDate(
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
) -> NoThrowValidator<String> {
    struct Container: Decodable {
        let d: Date
    }
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStrategy
    return NoThrowValidator {
        _ = try decoder.decode(Container.self, from: "{\"d\":\"\($0)\"}".data(using: .utf8) ?? Data())
    }
}

public func isDate(using formatter: DateFormatter) -> PredicateValidator<String> {
    check {
        formatter.date(from: $0) != nil
    }
}

public extension ExtendableValidator where Element == String {
    func match(regex: NSRegularExpression) -> Self {
        extended(with: SwiftValidation.match(regex: regex))
    }

    func isDate(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) -> Self {
        extended(with: SwiftValidation.isDate(dateDecodingStrategy: dateDecodingStrategy))
    }

    func isDate(using formatter: DateFormatter) -> Self {
        extended(with: SwiftValidation.isDate(using: formatter))
    }
}

#endif
