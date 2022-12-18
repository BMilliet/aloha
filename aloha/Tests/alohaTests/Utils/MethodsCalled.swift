final class MethodsCalled {

    var called = [Methods]()

    init() {}

    func add(_ method: Methods) {
        called.append(method)
    }

    func clear() {
        called = []
    }
}
