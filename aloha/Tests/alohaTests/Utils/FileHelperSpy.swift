@testable import aloha

struct FileHelperSpy: FileHelper {

    var homePathReturn = ""
    var existReturn = false
    var listReturn: [String]? = nil
    var createReturn = false

    func homePath() -> String {
        MethodsCalled.add(.fileHelperHomePathCalled)
        return homePathReturn
    }
    
    func exist(_ file: String) -> Bool {
        MethodsCalled.add(.fileHelperExistCalled)
        return existReturn
    }
    
    func list(_ path: String) -> [String]? {
        MethodsCalled.add(.fileHelperListCalled)
        return listReturn
    }
    
    func create(_ file: String, withIntermediateDirectories: Bool) -> Bool {
        MethodsCalled.add(.fileHelperCreateCalled)
        return createReturn
    }
}
