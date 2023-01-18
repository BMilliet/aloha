import Foundation

struct ListController {

    let ui: UI

    let templateUseCase: TemplateUseCaseProtocol

    func start() {

        let templates = templateUseCase.listTemplates()

        if templates.isEmpty {
            ui.message("🌱 No templates available here.")
        } else {
            ui.message("🌴 Available templates:")
            templates.forEach { ui.message(" - \($0)") }
        }
    }
}
