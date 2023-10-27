import XCTest
@testable import aloha

final class TemplateUseCaseTests: XCTestCase {

    func test_templatesDir() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).templatesDir()

        XCTAssertEqual(sut, "aloha/templates")
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func test_user_have_templateDir_success() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperExistCalled(path: "aloha/templates")
        ]

        fileHelper.existReturn = ["aloha/templates": true]

        XCTAssertTrue(TemplateUseCaseImpl(fileManager: fileHelper).userHaveTemplateDir())
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func test_user_have_templateDir_failure() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperExistCalled(path: "aloha/templates")
        ]

        fileHelper.existReturn = ["aloha/templates": false]

        XCTAssertFalse(TemplateUseCaseImpl(fileManager: fileHelper).userHaveTemplateDir())
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func test_isValidTemplateName() throws {
        let methodsCalled = MethodsCalled()
        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let useCase = TemplateUseCaseImpl(fileManager: fileHelper)

        XCTAssertFalse(useCase.isValidTemplateName("somePath.project/TemplateName"))
        XCTAssertFalse(useCase.isValidTemplateName("somePath.project"))
        XCTAssertFalse(useCase.isValidTemplateName("somePath/project/TemplateName"))
        XCTAssertFalse(useCase.isValidTemplateName("somePath/TemplateName"))
        XCTAssertTrue(useCase.isValidTemplateName("TemplateName"))
    }

    func test_getTemplate() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        fileHelper.listReturn = ["aloha/templates": ["template1"]]
        fileHelper.fileToRead  = ["aloha/templates/template1/control.json": ControlMock.json_regular]

        let expected: [Methods] = [
            .fileHelperListCalled(path: "aloha/templates"),
            .fileHelperReadFileCalled(path: "aloha/templates/template1/control.json"),
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).getTemplate("template1")

        XCTAssertNotNil(sut)
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
