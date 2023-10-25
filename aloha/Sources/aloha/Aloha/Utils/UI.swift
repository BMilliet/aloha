import Foundation

protocol UI {
    func message(_ text: String)
    func error(_ text: String)
    func debug(_ text: String)
    func userInput(_ message: String) -> String?
}

struct UIImpl: UI {

    private let verbose: Bool

    init(verbose: Bool) {
        self.verbose = verbose
    }

    func message(_ text: String) {
        print(text + Colors.reset)
    }

    func error(_ text: String) {
        print("❌ \(text)" + Colors.reset)
    }

    func debug(_ text: String) {
        if verbose {
            print(text + Colors.reset)
        }
    }

    func userInput(_ message: String = "") -> String? {
        if !message.isEmpty {
            self.message(message)
        }

        let value = readLine()
        return value
    }
}
