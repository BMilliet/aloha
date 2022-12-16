import XCTest
@testable import aloha

final class GenerateTemplateUseCaseTests: XCTestCase {

    func test() throws {
        MethodsCalled.clear()
        
        var fileHelper = FileHelperSpy()
        fileHelper.createReturn = false
        fileHelper.homePathReturn = "mock/path"
        fileHelper.listReturn = ["template1", "template2"]
        fileHelper.existReturn = true
        
        GenerateTemplateUseCase(
            fileManager: fileHelper,
            template: "template1"
        ).start()
        
        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled,
            .fileHelperListCalled
        ]
        
        XCTAssertEqual(MethodsCalled.called, expected)
        XCTAssertTrue(true)
    }
}
