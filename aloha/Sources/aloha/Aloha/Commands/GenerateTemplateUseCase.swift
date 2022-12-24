import Foundation

struct GenerateTemplateUseCase {
    let fileManager: FileHelper
    let ui: UI
    
    let template: String
    let name: String

    func start() {
        let home = fileManager.homePath()
        let templatesDir = home + Constants.templateDir
        
        ui.debug("search template: \(template)")
        ui.debug("input name: \(name)")
        
        ui.debug("home => \(home)")
        ui.debug("templates => \(templatesDir)")
        
        if invalidTemplateName(template) {
            ui.error("invalid template")
            return
        }

        createTemplateDirIfNeeded(templatesDir)

        guard let targetTemplatePath = findPath(target: template, in: templatesDir) else {
            ui.error("Could not find template")
            return
        }

        let template = getTemplate(jsonPath: targetTemplatePath,
                                   originAbs: "\(templatesDir)/\(template)",
                                   destAbs: fileManager.currentDir())

        print("==========")
        print(template?.targets)
        print("==========")

        template?.targets.forEach {
            copyAndRename($0, templatesDir)
        }
    }

    private func copyAndRename(_ item: ItemModel, _ templatesDir: String) {
        let name = URL(filePath: item.model).lastPathComponent
        let destination = "\(item.destination)/\(name)"
        fileManager.copy(from: item.model, to: destination)
        renameContent(destination)
    }

    private func renameContent(_ file: String) {
        print("LOCKING FILE")
        print(file)
        var filePath = file

        if file.contains("__name__") {
            print("Rename file name")
            filePath = rename(file, name: name)
            fileManager.move(from: file, to: filePath)
            print(filePath)
        }

        if fileManager.isDir(filePath) ?? false {
            print("is dir")
            fileManager.list(filePath)?.forEach {
                renameContent("\(filePath)/\($0)")
            }
        } else {
            print("========== file ==========")
            guard var fileContent = fileManager.readFile(filePath) else {
                print("could not read file => \(filePath)")
                return
            }

            fileContent = rename(fileContent, name: name)
            fileManager.write(content: fileContent, path: filePath)
        }
    }

    private func rename(_ str: String, name: String) -> String {
        return str.replacingOccurrences(of: "__name__", with: name)
    }
    
    private func createTemplateDirIfNeeded(_ templatesDir: String) {
        if !userHaveTemplateDir(templatesDir) {
            ui.debug("No templates dir found\nCreating templates dir...")
            createTemplateDir(templatesDir)
        }
    }
    
    private func invalidTemplateName(_ template: String) -> Bool {
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
    
    private func findPath(target template: String, in templatesDir: String) -> String? {
        if let files = fileManager.list(templatesDir) {

            for e in files {
                if e == template {
                    return "\(templatesDir)/\(e)"
                }
            }
        }

        return nil
    }

    private func getTemplate(jsonPath: String, originAbs: String, destAbs: String) -> TemplateModel? {
        if let template = getOriginalTemplate(jsonPath) {
            return TemplateModelFactory.build(
                template,
                originAbs: originAbs,
                destAbs: destAbs
            )
        }
        return nil
    }

    private func getOriginalTemplate(_ path: String) -> TemplateControl? {
        if let data = fileManager.readFile("\(path)/control.json")?.data(using: .utf8) {
            return JsonHelper.decode(type: TemplateControl.self, data)
        }
        return nil
    }
}
