# SwiftValidation

> Type-safe extendable Swift DSL to validate your objects.

![Swift Version](https://img.shields.io/badge/swift-5.4-brightgreen)

Heavily inspired by Kotlin [valiktor](https://github.com/valiktor/valiktor).

## Usage

```swift
XCTAssertNoThrow {
    try validate(user) {
        validate(\.id).isPositive()
        validate(\.email) {
            isNotEmpty()
            isEmail()
        }
        validate(\.dateString) { // validateAny(\.dateString) also works
            any {
                isDate(dateDecodingStrategy: .iso8601)
                isDate(dateDecodingStrategy: .secondsSince1970)
            }
        }
    }
}
```

## Installation

### Swift Package Manager

```swift
// In your `Package.swift`

dependencies: [
    .package(name: "SwiftValidation", url: "https://github.com/artbobrov/SwiftValidation", ...),
    ...
],
targets: [
    .target(
        name: ...,
        dependencies: [
            .product(name: "Example", package: "SwiftValidation"),
            ...
        ]
    ),
    ...
]
```

## Error Handling

Validation can throw `ValidationError`.

KeyPath can be named explicitly by `validate(\.age, name: "age").equals(to: 23)` then the error will be `PartialValidationError` with `PartialValidationError.propertyName == "age"`.

Nested validation is supported.

```swift
try validate(user) {
    validate(\.company, name: "company") {
        validate(\.catchPhrase, name: "catchPhrase").isNotEmpty()
    }
}
```

In case of `catchPhrase` is empty the propertyName equals to `company.catchPhrase`

## DisjunctionValidator, ConjuctionValidator

`DisjunctionValidator` has similar semantic to boolean disjunction operations.
At least one validator should accept the object to not fail.
In case of empty validators validation does nothing.

`ConjuctionValidator` has similar semantic to boolean conjuction operations.
All validators should accept the object to not fail.
In case of empty validators validation does nothing.

## Custom Validator

Create a function returning object implementing `Validator` protocol. Associated type `Value` is a type you want to validate.

To support dot notation create extension of `ExtendableValidator`. Associated type `Element` is a type you want to validate.

## Author

* [artbobrov](https://github.com/artbobrov)
