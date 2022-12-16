import ArgumentParser

extension Runner {

    struct Generate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Generate files.")

        @Argument(help: "The template to execute.")
        var template: String

        func run() throws {
            GenerateTemplateUseCase(
                fileManager: FileHelperImpl(),
                template: template
            ).start()
        }
    }
}
