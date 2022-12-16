import Foundation
import ArgumentParser

struct Constants {
    static var templateDir = ".aloha"
}

extension Runner {
    
    struct Generate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Generate files")

        @Argument(help: "The template to execute")
        var template: String

        func run() throws {
            let fileManager = FileManager.default

            print(template)
            print(fileManager.homeDirectoryForCurrentUser.path)
        }
    }
}
