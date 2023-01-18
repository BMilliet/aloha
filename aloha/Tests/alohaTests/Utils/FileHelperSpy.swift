import Foundation
import XCTest

@testable import aloha

struct FileHelperSpy: FileHelper {

    var currentDirReturn = "AlohaHome"
    var createDirReturn = false
    var homePathReturn = "AlohaHome/"
    var existReturn: [String: Bool] = [String: Bool]()
    var isDirReturn: [String: Bool] = [String: Bool]()
    var fileToRead: [String: String] = [String: String]()
    var listReturn: [String: [String]] = [String: [String]]()

    var methods: MethodsCalled

    func currentDir() -> String {
        methods.add(.fileHelperCurrentDirCalled)
        return currentDirReturn
    }

    func copy(from: String, to: String) {
        methods.add(.fileHelperCopy(from: from, to: to))
    }

    func move(from: String, to: String) {
        methods.add(.fileHelperMove(from: from, to: to))
    }

    func write(content: String, path: String) {
        methods.add(.fileHelperWrite(content: content, path: path))
    }

    func homePath() -> String {
        methods.add(.fileHelperHomePathCalled)
        return homePathReturn
    }

    func createDir(_ file: String, withIntermediateDirectories: Bool) -> Bool {
        methods.add(.fileHelperCreateDirCalled(
            path: file,
            withIntermediateDirectories: withIntermediateDirectories)
        )
        return createDirReturn
    }

    func exist(_ file: String) -> Bool {
        methods.add(.fileHelperExistCalled(path: file))
        do {
            return try XCTUnwrap(existReturn[file])
        } catch {
            XCTFail("❌ exist => \(file)")
        }
        return false
    }
    
    func list(_ path: String) -> [String]? {
        methods.add(.fileHelperListCalled(path: path))
        do {
            return try XCTUnwrap(listReturn[path])
        } catch {
            XCTFail("❌ list => \(path)")
        }
        return nil
    }

    func readFile(_ path: String) -> String? {
        methods.add(.fileHelperReadFileCalled(path: path))
        do {
            return try XCTUnwrap(fileToRead[path])
        } catch {
            XCTFail("❌ readFile => \(path)")
        }
        return nil
    }

    func isDir(_ path: String) -> Bool? {
        methods.add(.fileHelperIsDirCalled(path: path))
        do {
            return try XCTUnwrap(isDirReturn[path])
        } catch {
            XCTFail("❌ isDir => \(path)")
        }
        return false
    }
}
