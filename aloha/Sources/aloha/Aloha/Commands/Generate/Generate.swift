import ArgumentParser

extension Runner {

    struct Generate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Generate files.")

        @Argument(help: "The template to execute.")
        var template: String

        @Argument(help: "Name to replace in template.")
        var name: String

        func run() throws {
            GenerateController(
                name: name,
                template: template,
                ui: UIImpl(),
                templateUseCase: TemplateUseCaseImpl(fileManager: FileHelperImpl()),
                generateUseCase: GenerateTemplateUseCaseImpl(fileManager: FileHelperImpl())
            )
            .start()
        }
    }
}
