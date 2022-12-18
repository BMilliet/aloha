import Foundation

struct GenerateTemplateUseCase {
    let fileManager: FileHelper
    let ui: UI
    let template: String

    func start() {
        let home = fileManager.homePath()
        let templates = home + Constants.templateDir

        ui.message("home => \(home)")
        ui.message("templates => \(templates)")

        if invalidTemplateName(template) {
            print("invalid template")
            return
        }

        if !userHaveTemplateDir(templates) {
            createTemplateDir(templates)
        }

        guard let targetTemplate = findPath(target: template, in: templates) else {
            ui.error("Could not find template")
            return
        }

        readTemplate(targetTemplate)

        ui.message("choosen template => \(targetTemplate)")
    }

    private func invalidTemplateName(_ template: String) -> Bool {
        return template.isEmpty ||
        template.contains("/") ||
        template.contains(".")
    }

    private func userHaveTemplateDir(_ templates: String) -> Bool {
        return fileManager.exist(templates)
    }

    private func createTemplateDir(_ templates: String) {
        fileManager.createDir(templates, withIntermediateDirectories: true)
    }

    private func findPath(target template: String, in templates: String) -> String? {
        if let files = fileManager.list(templates) {

            for e in files {
                if e == template {
                    return e
                }
            }
        }

        return nil
    }

    private func readTemplate(_ path: String) -> String {
        return fileManager.readFile(path)
    }
}
