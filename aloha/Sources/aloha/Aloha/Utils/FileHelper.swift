import Foundation

protocol FileHelper {
    func homePath() -> String
    func exist(_ file: String) -> Bool
    func list(_ path: String) -> [String]?
    func isDir(_ path: String) -> Bool
    func currentDir() -> String

    @discardableResult
    func createDir(_ file: String, withIntermediateDirectories: Bool) -> Bool
    func readFile(_ path: String) -> String?
    func copy(from: String, to: String)
    func move(from: String, to: String)
    func write(content: String, path: String)
}

struct FileHelperImpl: FileHelper {

    private let fileManager = FileManager.default
    private let ui: UI

    private let prefix = Colors.magenta + "[FileHelper]"

    init(ui: UI) {
        self.ui = ui
    }

    func copy(from: String, to: String) {
        ui.debug(prefix +
                 Colors.cyan + " copy " +
                 Colors.reset + from +
                 Colors.cyan + " to " +
                 Colors.reset + to)

        do {
            try fileManager.copyItem(atPath: from, toPath: to)
        } catch {
            ui.error("Could not copy file \(from) to \(to)")
            ui.debug(Colors.red + error.localizedDescription)
        }
    }

    func homePath() -> String {
        fileManager.homeDirectoryForCurrentUser.relativePath
    }

    func exist(_ file: String) -> Bool {
        ui.debug(prefix +
                 Colors.cyan + " check if file exists " +
                 Colors.reset + file)

        return fileManager.fileExists(atPath: file)
    }

    func list(_ path: String) -> [String]? {
        ui.debug(prefix +
                 Colors.cyan + " list " +
                 Colors.reset + path)

        var content: [String]?
        do {
            content = try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            ui.error("Could not get content of \(path)")
            ui.debug(Colors.red + error.localizedDescription)
        }

        return content
    }

    func createDir(_ file: String, withIntermediateDirectories: Bool = false) -> Bool {
        ui.debug(prefix +
                 Colors.cyan + " create " +
                 Colors.reset + file)

        do {
            try fileManager.createDirectory(
                atPath: file,
                withIntermediateDirectories: withIntermediateDirectories)
            return true
        } catch {
            ui.error("Could not create \(file)")
            ui.debug(Colors.red + error.localizedDescription)
            return false
        }
    }

    func readFile(_ path: String) -> String? {
        ui.debug(prefix +
                 Colors.cyan + " read " +
                 Colors.reset + path)

        var content: String?
        do {
            content = try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            ui.error("Could not read \(path)")
            ui.debug(Colors.red + error.localizedDescription)
        }
        return content
    }

    func isDir(_ path: String) -> Bool {
        ui.debug(prefix +
                 Colors.cyan + " check if is dir " +
                 Colors.reset + path)

        var isDir: ObjCBool = false
        fileManager.fileExists(atPath: path, isDirectory: &isDir)
        return isDir.boolValue
    }

    func currentDir() -> String {
        return fileManager.currentDirectoryPath
    }

    func move(from: String, to: String) {
        ui.debug(prefix +
                 Colors.cyan + " move file " +
                 Colors.reset + from +
                 Colors.cyan + " to " +
                 Colors.reset + to)

        do {
            try fileManager.moveItem(atPath: from, toPath: to)
        } catch {
            ui.error("Could not move file from \(from) to \(to)")
            ui.debug(Colors.red + error.localizedDescription)
        }
    }

    func write(content: String, path: String) {
        ui.debug(prefix +
                 Colors.cyan + " write to " +
                 Colors.reset + path)

        do {
            try content.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            ui.error("Could not write to \(path)")
            ui.debug(Colors.red + error.localizedDescription)
        }
    }
}
