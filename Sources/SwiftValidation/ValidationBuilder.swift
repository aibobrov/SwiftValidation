import Foundation

@resultBuilder
public struct ValidationBuilder<Value> {
    public typealias Component = [AnyValidator<Value>]

    public static func buildBlock(_ components: Component...) -> Component {
        components.flatMap { $0.map { $0.eraseToAnyValidator() } }
    }

    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }

    public static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0.map { $0.eraseToAnyValidator() } }
    }

    public static func buildExpression<V: Validator>(_ expression: V) -> Component where V.Value == Value {
        [expression.eraseToAnyValidator()]
    }
}
