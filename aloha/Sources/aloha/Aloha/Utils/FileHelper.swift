import Foundation

protocol FileHelper {
    func homePath() -> String
    func exist(_ file: String) -> Bool
    func list(_ path: String) -> [String]?

    @discardableResult
    func createDir(_ file: String, withIntermediateDirectories: Bool) -> Bool
    func readFile(_ path: String) -> String
}

struct FileHelperImpl: FileHelper {
    private let fileManager = FileManager.default

    func homePath() -> String {
        fileManager.homeDirectoryForCurrentUser.path()
    }

    func exist(_ file: String) -> Bool {
        return fileManager.fileExists(atPath: file)
    }

    func list(_ path: String) -> [String]? {
        do {
            return try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            return nil
        }
    }

    func createDir(_ file: String, withIntermediateDirectories: Bool = false) -> Bool {
        let url = URL(filePath: file)

        do {
            try fileManager.createDirectory(
                at: url,
                withIntermediateDirectories: withIntermediateDirectories
            )
        } catch {
            print("could not create file")
            print("error => \(error.localizedDescription)")
            return false
        }

        return true
    }

    func readFile(_ path: String) -> String {
        print("readed file: \(path)")
        return ""
    }
}
