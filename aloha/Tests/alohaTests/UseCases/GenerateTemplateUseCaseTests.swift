import XCTest
@testable import aloha

final class GenerateTemplateUseCaseTests: XCTestCase {

    func testUserHaveTemplate() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)
        let ui = UISpy()

        fileHelper.createReturn = false
        fileHelper.homePathReturn = "mock/path"
        fileHelper.listReturn = ["template1", "template2"]
        fileHelper.existReturn = true

        GenerateTemplateUseCase(
            fileManager: fileHelper,
            ui: ui,
            template: "template1",
            name: "aloha"
        ).start()

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled,
            .fileHelperListCalled,
            .fileHelperReadFileCalled
        ]

        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testUserDontHaveTemplate() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)
        let ui = UISpy()

        fileHelper.createReturn = false
        fileHelper.homePathReturn = "mock/path"
        fileHelper.listReturn = ["template2"]
        fileHelper.existReturn = true

        GenerateTemplateUseCase(
            fileManager: fileHelper,
            ui: ui,
            template: "template1",
            name: "aloha"
        ).start()

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled,
            .fileHelperListCalled,
        ]

        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testUserDontHaveTemplatesDir() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)
        let ui = UISpy()

        fileHelper.createReturn = false
        fileHelper.homePathReturn = "mock/path"
        fileHelper.existReturn = false

        GenerateTemplateUseCase(
            fileManager: fileHelper,
            ui: ui,
            template: "template1",
            name: "aloha"
        ).start()

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled,
            .fileHelperCreateCalled,
            .fileHelperListCalled,
        ]

        XCTAssertEqual(methodsCalled.called, expected)
    }
}
