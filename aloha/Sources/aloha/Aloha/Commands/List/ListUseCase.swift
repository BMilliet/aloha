import Foundation

struct ListUseCase {
    let fileManager: FileHelper
    let ui: UI

    func start() {

        let templates = getTemplates()

        if templates.isEmpty {
            ui.message("🏝️ No templates available.")
        } else {
            ui.message("🌴 Available templates:")
            templates.forEach { ui.message(" - \($0)") }
        }
    }

    private func getTemplates() -> [String] {
        let home = fileManager.homePath()
        let templatesDir = home + Constants.templateDir
        return fileManager.list(templatesDir) ?? [String]()
    }
}
