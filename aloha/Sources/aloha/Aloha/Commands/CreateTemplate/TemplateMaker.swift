import ArgumentParser

extension Runner {

    struct TemplateMaker: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Create a template based on an existing structure.")

        @Flag(name: .shortAndLong, help: "Verbose mode.")
        var verbose = false

        func run() throws {
            TemplateMakerFactory
                .build(verbose: verbose)
                .start()
        }
    }
}
