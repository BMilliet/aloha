import Foundation

struct StartController {

    let ui: UI

    let templateUseCase: TemplateUseCaseProtocol

    func start() {
        if templateUseCase.userHaveTemplateDir() {
            ui.message("🏄‍♂️ Current dir" + Colors.cyan + " already have aloha config.")
        } else {
            templateUseCase.createAloha()
            ui.message(Colors.cyan + "🌊 Created aloha config " + Colors.reset + "on current project.")
        }
    }
}
