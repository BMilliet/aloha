import Foundation

struct GenerateTemplateUseCase {
    let fileManager: FileHelper
    let template: String

    func start() {
        let home = fileManager.homePath()
        let templates = home + Constants.templateDir

        validateTemplateName(template)
        validateIfUserHaveTemplateDir(templates)
        let targetTemplate = findPath(target: template, in: templates)
    }

    private func validateTemplateName(_ template: String) {
        if template.isEmpty || template.contains("/") || template.contains(".") {
            print("Invalid name")
            exit(1)
        }
    }

    private func validateIfUserHaveTemplateDir(_ templates: String) {
        if !fileManager.exist(templates) {
            fileManager.create(templates, withIntermediateDirectories: false)
        }
    }

    private func findPath(target template: String, in templates: String) -> String {
        guard let files = fileManager.list(templates) else {
            print("Could not list templates")
            exit(1)
        }

        for e in files {
            if e == template {
                return e
            }
        }

        exit(1)
    }
}
