import XCTest
@testable import aloha

final class TemplateUseCaseTests: XCTestCase {

    func testCreateTemplateDir() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperCreateDirCalled(path: "AlohaHome/.aloha/templates", withIntermediateDirectories: true)
        ]

        TemplateUseCaseImpl(fileManager: fileHelper).createTemplateDir()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testTemplatesDir() throws {
        let methodsCalled = MethodsCalled()

        let fileHelper = FileHelperSpy(methods: methodsCalled)

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).templatesDir()

        XCTAssertEqual(sut, "AlohaHome/.aloha/templates")
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
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
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
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

        fileHelper.listReturn = ["AlohaHome/.aloha/templates": ["template1"]]
        fileHelper.fileToRead  = ["AlohaHome/.aloha/templates/template1/control.json": ControlMock.json1]

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperListCalled(path: "AlohaHome/.aloha/templates"),
            .fileHelperHomePathCalled,
            .fileHelperReadFileCalled(path: "AlohaHome/.aloha/templates/template1/control.json"),
            .fileHelperHomePathCalled,
            .fileHelperCurrentDirCalled
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).getTemplate("template1")

        XCTAssertNotNil(sut)
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testReadTemplate() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        fileHelper.listReturn = ["AlohaHome/.aloha/templates": ["template1"]]
        fileHelper.fileToRead  = ["AlohaHome/.aloha/templates/template1/control.json": ControlMock.json1]

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperListCalled(path: "AlohaHome/.aloha/templates"),
            .fileHelperHomePathCalled,
            .fileHelperReadFileCalled(path: "AlohaHome/.aloha/templates/template1/control.json"),
        ]

        let sut = TemplateUseCaseImpl(fileManager: fileHelper).readTemplate("template1")

        XCTAssertNotNil(sut)
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
