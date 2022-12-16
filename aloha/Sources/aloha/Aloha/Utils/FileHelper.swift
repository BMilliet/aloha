import Foundation

protocol FileHelper {
    func homePath() -> String
    func exist(_ file: String) -> Bool
    func list(_ path: String) -> [String]?

    @discardableResult
    func create(_ file: String, withIntermediateDirectories: Bool) -> Bool
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

    func create(_ file: String, withIntermediateDirectories: Bool = false) -> Bool {
//        guard let url = URL(string: file) else {
//            return false
//        }
//
//        do {
//            try fileManager.createDirectory(
//                at: url,
//                withIntermediateDirectories: withIntermediateDirectories
//            )
//        } catch {
//            return false
//        }

        return true
    }
}
