enum TemplateMakerFactory {
    static func build(verbose: Bool) -> TemplateMakerController {

        let ui = UIImpl(verbose: verbose)
        let fileManager = FileHelperImpl(ui: ui)
        let templateUseCase = TemplateUseCaseImpl(fileManager: fileManager)

        return TemplateMakerController(ui: ui, templateUseCase: templateUseCase, fileHelper: fileManager)
    }
}
