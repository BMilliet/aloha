import ArgumentParser

struct Runner: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "aloha",
        abstract: "Aloha 🏝️",
        version: "0.0.2",
        subcommands: [
            Generate.self,
            List.self,
            Start.self,
            TemplateMaker.self
        ]
    )
}
