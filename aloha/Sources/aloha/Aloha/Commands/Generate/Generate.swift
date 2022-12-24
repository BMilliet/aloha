import ArgumentParser

extension Runner {

    struct Generate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Generate files.")

        @Argument(help: "The template to execute.")
        var template: String

        @Argument(help: "Name to replace in template.")
        var name: String

        func run() throws {
            GenerateTemplateUseCase(
                fileManager: FileHelperImpl(),
                ui: UIImpl(),
                template: template,
                name: name
            )
            .start()
        }
    }
}
