import Foundation

struct ListController {

    let ui: UI

    let templateUseCase: TemplateUseCaseProtocol

    func start() {

        if !templateUseCase.userHaveTemplateDir() {
            ui.message(Colors.cyan + "🐟 This project dont have aloha started yet.\n" +
                       Colors.reset + "You can start it by running the command:\n" +
                       Colors.green + "aloha start")
            return
        }

        let templates = templateUseCase.listTemplates()

        if templates.isEmpty {
            ui.message(Colors.magenta + "🌱 No templates " + Colors.reset + "available here.")
        } else {
            ui.message("🌴 Available templates:")
            templates.forEach { ui.message(Colors.cyan + " - " + Colors.reset + $0) }
        }
    }
}
