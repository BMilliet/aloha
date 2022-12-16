import Foundation

protocol FileHelper {
    func homePath() -> String
}

struct FileHelperImpl: FileHelper {
    private let fileManager = FileManager.default

    func homePath() -> String {
        fileManager.homeDirectoryForCurrentUser.path()
    }
}
