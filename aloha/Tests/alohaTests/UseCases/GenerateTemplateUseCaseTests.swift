import XCTest
@testable import aloha

final class GenerateTemplateUseCaseTests: XCTestCase {

    func testUserHaveTemplate() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)
        let ui = UISpy()

        let existingFiles = ["mock/path/.aloha/templates": true]

        var isDirFiles = ["CurrentDirPath/SomeProject/alohaExampleDir": true]
        isDirFiles["CurrentDirPath/SomeProject/Package.swift"] = false
        isDirFiles["CurrentDirPath/SomeProject/alohaCoordinator.swift"] = false

        var listReturn: [String: [String]] = ["mock/path/.aloha/templates": ["template1"]]
        listReturn["CurrentDirPath/SomeProject/alohaExampleDir"] = []

        var fileRead: [String: String] = ["mock/path/.aloha/templates/template1/control.json": ControlMock.json1]
        fileRead["CurrentDirPath/SomeProject/Package.swift"] = "nothing todo here"
        fileRead["CurrentDirPath/SomeProject/alohaCoordinator.swift"] = "final class __name__Coordinator {}"

        fileHelper.createDirReturn = false
        fileHelper.currentDirReturn = "CurrentDirPath"
        fileHelper.homePathReturn = "mock/path/"
        fileHelper.listReturn = listReturn
        fileHelper.existReturn = existingFiles
        fileHelper.isDirReturn = isDirFiles
        fileHelper.fileToRead = fileRead

        GenerateTemplateUseCase(
            fileManager: fileHelper,
            ui: ui,
            template: "template1",
            name: "aloha"
        ).start()

        let expected: [Methods] = [
            .fileHelperHomePathCalled,
            .fileHelperExistCalled(path: "mock/path/.aloha/templates"),
            .fileHelperListCalled(path: "mock/path/.aloha/templates"),
            .fileHelperCurrentDirCalled,
            .fileHelperReadFileCalled(path: "mock/path/.aloha/templates/template1/control.json"),

            .fileHelperCopy(from: "mock/path/.aloha/templates/template1/__name__ExampleDir",
                            to: "CurrentDirPath/SomeProject/__name__ExampleDir"),
            .fileHelperMove(from: "CurrentDirPath/SomeProject/__name__ExampleDir",
                            to: "CurrentDirPath/SomeProject/alohaExampleDir"),
            .fileHelperIsDirCalled(path: "CurrentDirPath/SomeProject/alohaExampleDir"),
            .fileHelperListCalled(path: "CurrentDirPath/SomeProject/alohaExampleDir"),
            
            .fileHelperCopy(from: "mock/path/.aloha/templates/template1/Package.swift",
                            to: "CurrentDirPath/SomeProject/Package.swift"),
            .fileHelperIsDirCalled(path: "CurrentDirPath/SomeProject/Package.swift"),
            .fileHelperReadFileCalled(path: "CurrentDirPath/SomeProject/Package.swift"),
            .fileHelperWrite(content: "nothing todo here",
                             path: "CurrentDirPath/SomeProject/Package.swift"),

            .fileHelperCopy(from: "mock/path/.aloha/templates/template1/__name__Coordinator.swift",
                            to: "CurrentDirPath/SomeProject/__name__Coordinator.swift"),
            .fileHelperMove(from: "CurrentDirPath/SomeProject/__name__Coordinator.swift",
                            to: "CurrentDirPath/SomeProject/alohaCoordinator.swift"),
            .fileHelperIsDirCalled(path: "CurrentDirPath/SomeProject/alohaCoordinator.swift"),
            .fileHelperReadFileCalled(path: "CurrentDirPath/SomeProject/alohaCoordinator.swift"),
            .fileHelperWrite(content: "final class alohaCoordinator {}",
                             path: "CurrentDirPath/SomeProject/alohaCoordinator.swift")
        ]

        XCTAssertEqual(methodsCalled.called, expected)
    }

    func testUserDontHaveTemplate() throws {
    }

    func testUserDontHaveTemplatesDir() throws {

    }
}
