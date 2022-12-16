import Foundation

final class MethodsCalled {
    static let shared = MethodsCalled()

    private init() {}

    static var called = [Methods]()

    static func add(_ method: Methods) {
        called.append(method)
    }

    static func clear() {
        called = []
    }
}
