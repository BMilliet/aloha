enum StartFactory {
    static func build(verbose: Bool) -> StartController {

        let ui = UIImpl(verbose: verbose)
        let fileManager = FileHelperImpl(ui: ui)
        let templateUseCase = TemplateUseCaseImpl(fileManager: fileManager)

        return StartController(ui: ui, templateUseCase: templateUseCase)
    }
}
