@testable import aloha

struct UISpy: UI {
    func debug(_ text: String) {}
    func message(_ text: String) {}
    func error(_ text: String) {}
    func userInput(_ message: String) -> String? {
        return message
    }
}
