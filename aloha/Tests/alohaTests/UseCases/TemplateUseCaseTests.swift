import XCTest
@testable import aloha

//func createTemplateDir()
//func templatesDir() -> String
//func userHaveTemplateDir() -> Bool
//func isValidTemplateName(_ name: String) -> Bool
//func getTemplate(_ name: String) -> TemplateControl?
//func readTemplate(_ name: String) -> TemplateControl?

final class TemplateUseCaseTests: XCTestCase {

    func testCreateTemplateDir() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperCreateDirCalled(path: "AlohaHome/.aloha/templates", withIntermediateDirectories: true)
        ]

        TemplateUseCaseImpl(fileManager: fileHelper).createTemplateDir()

        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testTemplatesDir() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).templatesDir()

        XCTAssertEqual(methodsCalled.called, expected)
        XCTAssertEqual(sut, "AlohaHome/.aloha/templates")
    }

    func testUserHaveTemplateDirSuccess() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled(path: "AlohaHome/.aloha/templates")
        ]

        fileHelper.existReturn = ["AlohaHome/.aloha/templates": true]

        XCTAssertTrue(TemplateUseCaseImpl(fileManager: fileHelper).userHaveTemplateDir())
        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testUserHaveTemplateDirFailure() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled(path: "AlohaHome/.aloha/templates")
        ]

        fileHelper.existReturn = ["AlohaHome/.aloha/templates": false]

        XCTAssertFalse(TemplateUseCaseImpl(fileManager: fileHelper).userHaveTemplateDir())
        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testIsValidTemplateName() throws {
        let methodsCalled = MethodsCalled()
        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let useCase = TemplateUseCaseImpl(fileManager: fileHelper)

        XCTAssertFalse(useCase.isValidTemplateName("somePath.project/TemplateName"))
        XCTAssertFalse(useCase.isValidTemplateName("somePath.project"))
        XCTAssertFalse(useCase.isValidTemplateName("somePath/project/TemplateName"))
        XCTAssertFalse(useCase.isValidTemplateName("somePath/TemplateName"))
        XCTAssertTrue(useCase.isValidTemplateName("TemplateName"))
    }

    func testGetTemplate() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperCreateDirCalled(path: "AlohaHome/.aloha/templates", withIntermediateDirectories: true)
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).getTemplate("template1")

        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testReadTemplate() throws {
        
    }
}
