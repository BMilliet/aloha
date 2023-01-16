import Foundation

protocol GenerateTemplateUseCaseProtocol {
    func isInCorrectDir(control: TemplateControl?) -> Bool
    func createContent(name: String, template: TemplateControl, templatesDir: String)
}

struct GenerateTemplateUseCaseImpl: GenerateTemplateUseCaseProtocol {

    let fileManager: FileHelper

    func isInCorrectDir(control: TemplateControl?) -> Bool {
        guard let templateExpectedDir = control?.currentDir else { return false }
        return fileManager.currentDirName() == templateExpectedDir
    }

    func createContent(name: String, template: TemplateControl, templatesDir: String) {
        template.targets.forEach {
            copyAndRename($0, templatesDir, name)
        }
    }

    // MARK: - Private methods

    private func copyAndRename(_ item: ItemControl, _ templatesDir: String, _ name: String) {
        let name = URL(filePath: item.model).lastPathComponent
        let destination = "\(item.destination)/\(name)"
        fileManager.copy(from: item.model, to: destination)
        renameContent(destination, name: name)
    }

    private func replace(_ str: String, with word: String) -> String {
        return str.replacingOccurrences(of: Constants.replacePattern, with: word)
    }

    private func renameContent(_ file: String, name: String) {
        var filePath = file

        if file.contains(Constants.replacePattern) {
            filePath = replace(file, with: name)
            fileManager.move(from: file, to: filePath)
        }

        guard let isDir = fileManager.isDir(filePath) else {
            return
        }

        if isDir {
            fileManager.list(filePath)?.forEach {
                renameContent("\(filePath)/\($0)", name: name)
            }
        } else {
            guard var fileContent = fileManager.readFile(filePath) else { return }
            fileContent = replace(fileContent, with: name)
            fileManager.write(content: fileContent, path: filePath)
        }
    }
}