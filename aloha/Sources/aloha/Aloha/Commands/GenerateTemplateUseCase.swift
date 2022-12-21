import Foundation

struct GenerateTemplateUseCase {
    let fileManager: FileHelper
    let ui: UI
    
    let template: String
    let name: String
    
    func start() {
        let home = fileManager.homePath()
        let templates = home + Constants.templateDir
        
        ui.debug("search template: \(template)")
        ui.debug("input name: \(name)")
        
        ui.debug("home => \(home)")
        ui.debug("templates => \(templates)")
        
        if invalidTemplateName(template) {
            ui.error("invalid template")
            return
        }
        
        createTemplateDirIfNeeded(templates)
        
        guard let targetTemplate = findPath(target: template, in: templates) else {
            ui.error("Could not find template")
            return
        }
        
        readTemplate(targetTemplate)
        
        ui.message("choosen template => \(targetTemplate)")
    }
    
    private func createTemplateDirIfNeeded(_ templates: String) {
        if !userHaveTemplateDir(templates) {
            ui.debug("No templates dir found\nCreating templates dir...")
            createTemplateDir(templates)
        }
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
                    return "\(templates)/\(e)"
                }
            }
        }
        
        return nil
    }
    
    private func readTemplate(_ path: String) -> String? {
        guard let data = fileManager.readFile("\(path)/control.json")?.data(using: .utf8) else {
            return nil
        }

        let model = JsonHelper.decode(type: TemplateControl.self, data)
        print(model)
        return ""
    }
}
