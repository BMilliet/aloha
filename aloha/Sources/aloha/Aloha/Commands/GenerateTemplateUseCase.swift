import Foundation

struct GenerateTemplateUseCase {
    let fileManager: FileHelper
    let ui: UI
    
    let template: String
    let name: String

    func start() {
        let home = fileManager.homePath()
        let templatesDir = home + Constants.templateDir

        if invalidTemplateName() {
            ui.error("invalid template")
            ui.error("avoid using dot and slash")
            return
        }

        if !userHaveTemplateDir(templatesDir) {
            ui.error("No templates dir found\nCreating templates dir...")
            createTemplateDir(templatesDir)
            return
        }

        guard let targetTemplatePath = findTemplatePath(in: templatesDir) else {
            ui.error("Could not find template")
            return
        }

        let templateModel = getTemplate(jsonPath: targetTemplatePath,
                                        originAbs: "\(templatesDir)/\(template)",
                                        destAbs: fileManager.currentDir())

        templateModel?.targets.forEach {
            copyAndRename($0, templatesDir)
        }

        ui.message("🤙 Template \(template) generated with name \(name)")
    }

    private func copyAndRename(_ item: ItemControl, _ templatesDir: String) {
        let name = URL(filePath: item.model).lastPathComponent
        let destination = "\(item.destination)/\(name)"
        fileManager.copy(from: item.model, to: destination)
        renameContent(destination)
    }

    private func renameContent(_ file: String) {
        var filePath = file

        if file.contains(Constants.replacePattern) {
            filePath = replace(file)
            fileManager.move(from: file, to: filePath)
        }

        guard let isDir = fileManager.isDir(filePath) else {
            ui.error("Could not verify file to rename")
            return
        }

        if isDir {
            fileManager.list(filePath)?.forEach {
                renameContent("\(filePath)/\($0)")
            }
        } else {
            guard var fileContent = fileManager.readFile(filePath) else { return }
            fileContent = replace(fileContent)
            fileManager.write(content: fileContent, path: filePath)
        }
    }

    private func replace(_ str: String) -> String {
        return str.replacingOccurrences(of: Constants.replacePattern, with: name)
    }

    private func invalidTemplateName() -> Bool {
        return template.isEmpty ||
        template.contains("/") ||
        template.contains(".")
    }

    private func userHaveTemplateDir(_ templatesDir: String) -> Bool {
        return fileManager.exist(templatesDir)
    }

    private func createTemplateDir(_ templatesDir: String) {
        fileManager.createDir(templatesDir, withIntermediateDirectories: true)
    }

    private func findTemplatePath(in templatesDir: String) -> String? {
        if let files = fileManager.list(templatesDir) {

            for e in files {
                if e == template {
                    return "\(templatesDir)/\(e)"
                }
            }
        }
        return nil
    }

    private func getTemplate(jsonPath: String, originAbs: String, destAbs: String) -> TemplateControl? {
        if let template = getOriginalTemplate(jsonPath) {
            return convertToAbsolutePaths(template,
                                          originAbs: originAbs,
                                          destAbs: destAbs)
        }
        return nil
    }

    private func getOriginalTemplate(_ path: String) -> TemplateControl? {
        if let data = fileManager.readFile("\(path)/\(Constants.control)")?.data(using: .utf8) {
            return JsonHelper.decode(type: TemplateControl.self, data)
        }
        return nil
    }
    
    private func convertToAbsolutePaths(_ control: TemplateControl,
                                        originAbs: String,
                                        destAbs: String) -> TemplateControl {

        let item = control.targets.map {
            ItemControl(model: "\(originAbs)/\($0.model)",
                        destination: "\(destAbs)/\($0.destination)")
        }

        return TemplateControl(targets: item)
    }
}
