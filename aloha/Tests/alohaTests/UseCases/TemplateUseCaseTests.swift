import XCTest
@testable import aloha

final class TemplateUseCaseTests: XCTestCase {

    func testTemplatesDir() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).templatesDir()

        XCTAssertEqual(sut, "Aloha/templates")
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testUserHaveTemplateDirSuccess() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperExistCalled(path: "Aloha/templates")
        ]

        fileHelper.existReturn = ["Aloha/templates": true]

        XCTAssertTrue(TemplateUseCaseImpl(fileManager: fileHelper).userHaveTemplateDir())
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testUserHaveTemplateDirFailure() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperExistCalled(path: "Aloha/templates")
        ]

        fileHelper.existReturn = ["Aloha/templates": false]

        XCTAssertFalse(TemplateUseCaseImpl(fileManager: fileHelper).userHaveTemplateDir())
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
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

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        fileHelper.listReturn = ["Aloha/templates": ["template1"]]
        fileHelper.fileToRead  = ["Aloha/templates/template1/control.json": ControlMock.json1]

        let expected: [Methods] = [
            .fileHelperListCalled(path: "Aloha/templates"),
            .fileHelperReadFileCalled(path: "Aloha/templates/template1/control.json"),
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).getTemplate("template1")

        XCTAssertNotNil(sut)
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
