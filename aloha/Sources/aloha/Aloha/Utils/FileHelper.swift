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

    func copy(from: String, to: String) {
        do {
            try fileManager.copyItem(atPath: from, toPath: to)
        } catch {
            print(error)
        }
    }

    func homePath() -> String {
        fileManager.homeDirectoryForCurrentUser.relativePath
    }

    func exist(_ file: String) -> Bool {
        return fileManager.fileExists(atPath: file)
    }

    func list(_ path: String) -> [String]? {
        return try? fileManager.contentsOfDirectory(atPath: path)
    }

    func createDir(_ file: String, withIntermediateDirectories: Bool = false) -> Bool {
        do {
            try fileManager.createDirectory(
                atPath: file,
                withIntermediateDirectories: withIntermediateDirectories)
            return true
        } catch {
            print(error)
            return false
        }
    }

    func readFile(_ path: String) -> String? {
        var content: String?
        do {
            content = try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            print(error)
        }
        return content
    }

    func isDir(_ path: String) -> Bool {
        var isDir: ObjCBool = false
        fileManager.fileExists(atPath: path, isDirectory: &isDir)
        return isDir.boolValue
    }

    func currentDir() -> String {
        return fileManager.currentDirectoryPath
    }

    func move(from: String, to: String) {
        try? fileManager.moveItem(atPath: from, toPath: to)
    }

    func write(content: String, path: String) {
        do {
            try content.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
    }
}
