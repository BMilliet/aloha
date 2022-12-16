import ArgumentParser

struct Runner: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "aloha",
        abstract: "Aloha 🏝️",
        version: "0.0.1",
        subcommands: [
            Generate.self
        ]
    )
}
