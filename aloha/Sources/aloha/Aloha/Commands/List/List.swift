import ArgumentParser

extension Runner {

    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "List available templates.")

        func run() throws {
            ListController(
                ui: UIImpl(),
                templateUseCase: TemplateUseCaseImpl(fileManager: FileHelperImpl())
            )
            .start()
        }
    }
}
