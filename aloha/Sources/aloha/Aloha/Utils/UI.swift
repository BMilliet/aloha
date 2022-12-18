protocol UI {
    func message(_ text: String)
    func error(_ text: String)
}

struct UIImpl: UI {
    func message(_ text: String) {
        print(text)
    }

    func error(_ text: String) {
        print(text)
    }
}
