struct GenerateController {

    let name: String
    let template: String

    let ui: UI
    let templateUseCase: TemplateUseCaseProtocol
    let generateUseCase: GenerateTemplateUseCaseProtocol

    func start() {

        if !templateUseCase.isValidTemplateName(template) {
            ui.error("invalid template")
            ui.error("avoid using dot and slash")
            return
        }

        if !templateUseCase.userHaveTemplateDir() {
            ui.error("No templates dir found")
            ui.message("Run the command \"start\" to create it.")
            return
        }

        guard let templateModel = templateUseCase.getTemplate(template) else {
            ui.error("Could not find template or template is invalid")
            ui.message("Run the command \"list\" to check if template exists, if it does, check the control file with command check")
            return
        }

        generateUseCase.createContent(name: name,
                                      template: templateModel,
                                      templatesDir: templateUseCase.templatesDir())

        ui.message("🤙 Template " +
                   Colors.magenta + template +
                   Colors.reset + " generated with name " +
                   Colors.cyan + name)
    }
}
