import XCTest

@testable import aloha

struct UISpy: UI {

    var registeredUserInput: [String: String] = [String: String]()

    func debug(_ text: String) {}
    func message(_ text: String) {}
    func error(_ text: String) {}

    func userInput(_ message: String) -> String? {
        do {
            return try XCTUnwrap(registeredUserInput[message])
        } catch {
            XCTFail("❌ could not get input for message => \(message)")
        }
        return nil
    }
}
