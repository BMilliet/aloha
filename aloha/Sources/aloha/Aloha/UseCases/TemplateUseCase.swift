protocol TemplateUseCaseProtocol {
    func templatesDir() -> String
    func userHaveTemplateDir() -> Bool
    func isValidTemplateName(_ name: String) -> Bool
    func getTemplate(_ name: String) -> TemplateControl?
    func listTemplates() -> [String]
    func createAloha()
}

struct TemplateUseCaseImpl: TemplateUseCaseProtocol {

    let fileManager: FileHelper

    func createAloha() {
        fileManager.createDir(Constants.templateDir, withIntermediateDirectories: true)
    }

    func listTemplates() -> [String] {
        let templatesDir = Constants.templateDir
        return fileManager.list(templatesDir) ?? [String]()
    }

    func isValidTemplateName(_ name: String) -> Bool {
        return !name.isEmpty &&
        !name.contains("/") &&
        !name.contains(".")
    }

    func userHaveTemplateDir() -> Bool {
        return fileManager.exist(templatesDir())
    }

    func templatesDir() -> String {
        return Constants.templateDir
    }

    func getTemplate(_ name: String) -> TemplateControl? {
        guard let path = findTemplatePath(name) else { return nil }
        guard let data = fileManager.readFile("\(path)/\(Constants.control)")?.data(using: .utf8) else {
            return nil
        }

        guard let rawTemplate = JsonHelper.decode(type: TemplateControl.self, data) else {
            return nil
        }

        let item = rawTemplate.targets.map {
            ItemControl(model: "\(path)/\($0.model)",
                        destination: $0.destination)
        }

        return TemplateControl(targets: item, justCopy: rawTemplate.justCopy)
    }

    // MARK: - Private methods

    private func findTemplatePath(_ name: String) -> String? {
        let files = listTemplates()
        let template = files.first { $0 == name }

        guard let template = template else { return nil }
        return "\(templatesDir())/\(template)"
    }
}
