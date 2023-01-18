protocol TemplateUseCaseProtocol {
    func templatesDir() -> String
    func userHaveTemplateDir() -> Bool
    func isValidTemplateName(_ name: String) -> Bool
    func getTemplate(_ name: String) -> TemplateControl?
}

struct TemplateUseCaseImpl: TemplateUseCaseProtocol {
    let fileManager: FileHelper

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

        return TemplateControl(targets: item)
    }

    // MARK: - Private methods

    private func findTemplatePath(_ name: String) -> String? {
        guard let files = fileManager.list(templatesDir()) else { return nil }
        let template = files.first { $0 == name }

        guard let template = template else { return nil }
        return "\(templatesDir())/\(template)"
    }
}
