import Foundation

struct Constants {
    static let templateDir    = ".aloha/templates"
    static let replacePattern = "__name__"
    static let control        = "control.json"

    static let development: Bool = {
        ProcessInfo.processInfo.environment["ALOHA_DEV"] == "true"
    }()
}
