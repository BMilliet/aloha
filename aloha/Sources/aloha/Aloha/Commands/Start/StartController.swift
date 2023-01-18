import Foundation

struct StartController {

    let ui: UI

    let templateUseCase: TemplateUseCaseProtocol

    func start() {
        if templateUseCase.userHaveTemplateDir() {
            ui.message("🏄‍♂️ Current dir already have Aloha config")
        } else {
            templateUseCase.createAloha()
            ui.message("🌊 Created Aloha config on current dir")
        }
    }
}
