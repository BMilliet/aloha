enum GenerateFactory {
    static func build(name: String, template: String, verbose: Bool) -> GenerateController {

        let ui = UIImpl(verbose: verbose)
        let fileManager = FileHelperImpl(ui: ui)

        let templateUseCase = TemplateUseCaseImpl(fileManager: fileManager)
        let generateUseCase = GenerateTemplateUseCaseImpl(fileManager: fileManager, ui: ui)

        return GenerateController(name: name,
                                  template: template,
                                  ui: ui,
                                  templateUseCase: templateUseCase,
                                  generateUseCase: generateUseCase)
    }
}
