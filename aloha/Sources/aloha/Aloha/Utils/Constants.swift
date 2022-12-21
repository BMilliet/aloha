import Foundation

struct Constants {
    static var templateDir = ".aloha/templates"
    
    static var development: Bool = {
        ProcessInfo.processInfo.environment["ALOHA_DEV"] == "true"
    }()
}
