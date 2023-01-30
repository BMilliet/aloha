import ArgumentParser

extension Runner {

    struct Start: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Start aloha templates for current dir.")

        @Flag(name: .shortAndLong, help: "Verbose mode.")
        var verbose = false

        func run() throws {
            StartFactory
                .build(verbose: verbose)
                .start()
        }
    }
}
