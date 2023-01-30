import ArgumentParser

extension Runner {

    struct Generate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Generate files.")

        @Argument(help: "The template to execute.")
        var template: String

        @Argument(help: "Name to replace in template.")
        var name: String

        @Flag(name: .shortAndLong, help: "Verbose mode.")
        var verbose = false

        func run() throws {
            GenerateFactory
                .build(name: name,
                       template: template,
                       verbose: verbose)
                .start()
        }
    }
}
