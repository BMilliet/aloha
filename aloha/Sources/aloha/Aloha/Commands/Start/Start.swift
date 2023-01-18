import ArgumentParser

extension Runner {

    struct Start: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Start aloha templates for current dir.")

        func run() throws {
            StartController(
                ui: UIImpl(),
                templateUseCase: TemplateUseCaseImpl(fileManager: FileHelperImpl())
            )
            .start()
        }
    }
}
