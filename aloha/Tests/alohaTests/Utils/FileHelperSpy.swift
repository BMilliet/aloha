import Foundation

@testable import aloha

struct FileHelperSpy: FileHelper {

    var homePathReturn = ""
    var existReturn = false
    var listReturn: [String]? = nil
    var createReturn = false
    var fileToRead = ""

    var methods: MethodsCalled

    func homePath() -> String {
        methods.add(.fileHelperHomePathCalled)
        return homePathReturn
    }
    
    func exist(_ file: String) -> Bool {
        methods.add(.fileHelperExistCalled)
        return existReturn
    }
    
    func list(_ path: String) -> [String]? {
        methods.add(.fileHelperListCalled)
        return listReturn
    }

    func listAbsolute(_ path: String) -> [URL] {
        return [URL]()
    }

    func createDir(_ file: String, withIntermediateDirectories: Bool) -> Bool {
        methods.add(.fileHelperCreateCalled)
        return createReturn
    }

    func readFile(_ path: String) -> String? {
        methods.add(.fileHelperReadFileCalled)
        return fileToRead
    }

    func isDir(_ path: String) -> Bool? {
        return false
    }

    func currentDir() -> String {
        return ""
    }

    func copy(from: String, to: String) {
        //
    }

    func move(from: String, to: String) {
        //
    }

    func write(content: String, path: String) {
        //
    }
}
