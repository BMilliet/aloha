import ArgumentParser

extension Runner {

    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "List available templates.")

        func run() throws {
            ListUseCase(
                fileManager: FileHelperImpl(),
                ui: UIImpl()
            )
            .start()
        }
    }
}
