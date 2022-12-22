import Foundation

protocol FileHelper {
    func homePath() -> String
    func exist(_ file: String) -> Bool
    func list(_ path: String) -> [String]?
    func listAbsolute(_ path: String) -> [URL]
    func isDir(_ path: String) -> Bool?
    func currentDir() -> String

    @discardableResult
    func createDir(_ file: String, withIntermediateDirectories: Bool) -> Bool
    func readFile(_ path: String) -> String?
    func copy(from: String, to: String)
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

    // list abs paths TODO
    func listAbsolute(_ path: String) -> [URL] {
        var content = [URL]()

        let url = URL(filePath: path)
        if let dir = fileManager.enumerator(at: url, includingPropertiesForKeys: nil) {
            for case let f as URL in dir {
                content.append(f)
            }
        }

        return content
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
}
