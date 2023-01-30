enum ListFactory {
    static func build(verbose: Bool) -> ListController {

        let ui = UIImpl(verbose: verbose)
        let fileManager = FileHelperImpl(ui: ui)
        let templateUseCase = TemplateUseCaseImpl(fileManager: fileManager)

        return ListController(ui: ui, templateUseCase: templateUseCase)
    }
}
