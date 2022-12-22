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
        
        let template = getTemplate(targetTemplatePath)

        template?.targets.forEach {
            doSomething(templatesDir: templatesDir, $0)
        }

        print(fileManager.currentDir())
    }

    private func doSomething(templatesDir: String, _ item: ItemControl) {
        let modelPath = "\(templatesDir)/\(template)/\(item.model)"
        let modelName = URL(filePath: modelPath).lastPathComponent
        
        print(modelPath)
        print(modelName)

        print("🌴 Copying template...")

        fileManager.copy(from: modelPath, to: "\(item.destination)/\(modelName)")
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
    
    private func getTemplate(_ path: String) -> TemplateControl? {
        guard let data = fileManager.readFile("\(path)/control.json")?.data(using: .utf8) else {
            return nil
        }

        return JsonHelper.decode(type: TemplateControl.self, data)
    }
}
