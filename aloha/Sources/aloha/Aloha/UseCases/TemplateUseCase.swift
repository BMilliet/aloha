protocol TemplateUseCaseProtocol {
    func createTemplateDir()
    func templatesDir() -> String
    func userHaveTemplateDir() -> Bool
    func isValidTemplateName(_ name: String) -> Bool
    func getTemplate(_ name: String) -> TemplateControl?
    func readTemplate(_ name: String) -> TemplateControl?
}

struct TemplateUseCaseImpl: TemplateUseCaseProtocol {
    let fileManager: FileHelper

    func isValidTemplateName(_ name: String) -> Bool {
        return !name.isEmpty &&
        !name.contains("/") &&
        !name.contains(".")
    }

    func createTemplateDir() {
        fileManager.createDir(templatesDir(), withIntermediateDirectories: true)
    }

    func userHaveTemplateDir() -> Bool {
        return fileManager.exist(templatesDir())
    }

    func templatesDir() -> String {
        return fileManager.homePath() + Constants.templateDir
    }

    func readTemplate(_ name: String) -> TemplateControl? {
        guard let path = findTemplatePath(name) else { return nil }
        guard let data = fileManager.readFile("\(path)/\(Constants.control)")?.data(using: .utf8) else {
            return nil
        }

        return JsonHelper.decode(type: TemplateControl.self, data)
    }

    func getTemplate(_ name: String) -> TemplateControl? {
        guard let template = readTemplate(name) else { return nil }

        let origin = "\(templatesDir())/\(name)"
        let output = fileManager.currentDir()
        return convertToAbsolutePaths(template, originAbs: origin, destAbs: output)
    }

    // MARK: - Private methods

    private func findTemplatePath(_ name: String) -> String? {
        guard let files = fileManager.list(templatesDir()) else { return nil }
        return files.first { $0 == name }
    }

    private func convertToAbsolutePaths(_ control: TemplateControl,
                                        originAbs: String,
                                        destAbs: String) -> TemplateControl {

        let item = control.targets.map {
            ItemControl(model: "\(originAbs)/\($0.model)",
                        destination: "\(destAbs)/\($0.destination)")
        }

        return TemplateControl(currentDir: control.currentDir,
                               targets: item)
    }
}
