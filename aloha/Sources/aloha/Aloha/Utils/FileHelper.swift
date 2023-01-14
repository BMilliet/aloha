import Foundation

protocol FileHelper {
    func homePath() -> String
    func exist(_ file: String) -> Bool
    func list(_ path: String) -> [String]?
    func isDir(_ path: String) -> Bool?
    func currentDir() -> String
    func currentDirName() -> String

    @discardableResult
    func createDir(_ file: String, withIntermediateDirectories: Bool) -> Bool
    func readFile(_ path: String) -> String?
    func copy(from: String, to: String)
    func move(from: String, to: String)
    func write(content: String, path: String)
}

struct FileHelperImpl: FileHelper {
    func copy(from: String, to: String) {
        do {
            try fileManager.copyItem(atPath: from, toPath: to)
        } catch {
            print("error => \(error.localizedDescription)")
        }
    }
    
    private let fileManager = FileManager.default

    func homePath() -> String {
        fileManager.homeDirectoryForCurrentUser.path()
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
                at: URL(filePath: file),
                withIntermediateDirectories: withIntermediateDirectories)
            return true
        } catch {
            return false
        }
    }

    func readFile(_ path: String) -> String? {
        return try? String(contentsOfFile: path, encoding: .utf8)
    }

    func isDir(_ path: String) -> Bool? {
        let url = URL(filePath: path)
        guard let file = try? url.resourceValues(forKeys: [.isDirectoryKey]) else {
            return nil
        }

        return file.isDirectory
    }

    func currentDir() -> String {
        return fileManager.currentDirectoryPath
    }

    func currentDirName() -> String {
        let name = fileManager.currentDirectoryPath.split(separator: "/").last
        return String(name ?? "")
    }

    func move(from: String, to: String) {
        try? fileManager.moveItem(atPath: from, toPath: to)
    }

    func write(content: String, path: String) {
        do {
            try content.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}
