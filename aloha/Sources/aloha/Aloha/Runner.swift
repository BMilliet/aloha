import ArgumentParser

struct Runner: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "aloha",
        abstract: "Aloha 🏝️",
        version: "1.1.0",
        subcommands: [
            Generate.self,
            List.self,
            Start.self
        ]
    )
}
