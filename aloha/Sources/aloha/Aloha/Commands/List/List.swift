import ArgumentParser

extension Runner {

    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "List available templates.")

        @Flag(name: .shortAndLong, help: "Verbose mode.")
        var verbose = false

        func run() throws {
            ListFactory
                .build(verbose: verbose)
                .start()
        }
    }
}
