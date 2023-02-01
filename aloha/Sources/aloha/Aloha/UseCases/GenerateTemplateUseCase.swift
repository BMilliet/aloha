import Foundation

protocol GenerateTemplateUseCaseProtocol {
    func createContent(name: String, template: TemplateControl, templatesDir: String)
}

struct GenerateTemplateUseCaseImpl: GenerateTemplateUseCaseProtocol {

    let fileManager: FileHelper
    let ui: UI

    func createContent(name: String, template: TemplateControl, templatesDir: String) {
        template.targets.forEach {
            copyAndRename($0, templatesDir, name, justCopy: template.justCopy ?? [])
        }
    }

    // MARK: - Private methods

    private func copyAndRename(_ item: ItemControl, _ templatesDir: String, _ name: String, justCopy: [String]) {
        guard let fileName = item.model.split(separator: "/").last else { return }
        let destination = "\(item.destination)/" + fileName
        fileManager.copy(from: item.model, to: destination)
        renameContent(destination, name: name, justCopy: justCopy)
    }

    private func replace(_ str: String, with word: String) -> String {
        return str.replacingOccurrences(of: Constants.replacePattern, with: word)
    }

    private func renameContent(_ file: String, name: String, justCopy: [String]) {
        var filePath = file
        let fileName = String(filePath.split(separator: "/").last ?? "")

        if justCopy.contains(fileName) {
            ui.debug(Colors.green + "[GENERATE]" +
                     Colors.cyan + " just copy " +
                     Colors.reset + fileName)
            return
        }

        if file.contains(Constants.replacePattern) {
            filePath = replace(file, with: name)
            fileManager.move(from: file, to: filePath)
        }

        if fileManager.isDir(filePath) {
            fileManager.list(filePath)?.forEach {
                renameContent("\(filePath)/\($0)", name: name, justCopy: justCopy)
            }
        } else {
            guard var fileContent = fileManager.readFile(filePath) else { return }
            fileContent = replace(fileContent, with: name)
            fileManager.write(content: fileContent, path: filePath)
        }
    }
}
