import XCTest
@testable import aloha

final class GenerateTemplateUseCaseTests: XCTestCase {

    func testIsInCorrectDirSuccess() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        fileHelper.currentDirNameReturn = "ProjectDir"

        let expected: [Methods] = [
            .fileHelperCurrentDirNameCalled
        ]

        XCTAssertTrue(GenerateTemplateUseCaseImpl(fileManager: fileHelper).isInCorrectDir(control: ControlHelper.getControl1()))
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testIsInCorrectDirFailure() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        fileHelper.currentDirNameReturn = "ProjectDir2"

        let expected: [Methods] = [
            .fileHelperCurrentDirNameCalled
        ]

        XCTAssertFalse(GenerateTemplateUseCaseImpl(fileManager: fileHelper).isInCorrectDir(control: ControlHelper.getControl1()))
        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testCreateContent() throws {
        let methodsCalled = MethodsCalled()

        var fileHelper = FileHelperSpy(methods: methodsCalled)

        var isDirFiles = ["SomeProject/alohaExampleDir": true]
        isDirFiles["SomeProject/Package.swift"] = false
        isDirFiles["SomeProject/alohaCoordinator.swift"] = false

        isDirFiles["SomeProject/alohaExampleDir/alohaController.swift"] = false
        fileHelper.listReturn = ["SomeProject/alohaExampleDir": ["__name__Controller.swift"]]

        var filesToRead = ["SomeProject/Package.swift": "nothing to do here"]
        filesToRead["SomeProject/alohaCoordinator.swift"] = "final class __name__Coordinator {}"
        filesToRead["SomeProject/alohaExampleDir/alohaController.swift"] = "final class __name__Controller {}"

        fileHelper.isDirReturn = isDirFiles
        fileHelper.fileToRead = filesToRead

        let expected: [Methods] = [
            // First item
            .fileHelperCopy(from: "__name__ExampleDir",
                            to: "SomeProject/__name__ExampleDir"),
            .fileHelperMove(from: "SomeProject/__name__ExampleDir",
                            to: "SomeProject/alohaExampleDir"),
            .fileHelperIsDirCalled(path: "SomeProject/alohaExampleDir"),
            .fileHelperListCalled(path: "SomeProject/alohaExampleDir"),
            // First item nested file
            .fileHelperMove(from: "SomeProject/alohaExampleDir/__name__Controller.swift",
                            to: "SomeProject/alohaExampleDir/alohaController.swift"),
            .fileHelperIsDirCalled(path: "SomeProject/alohaExampleDir/alohaController.swift"),
            .fileHelperReadFileCalled(path: "SomeProject/alohaExampleDir/alohaController.swift"),
            .fileHelperWrite(content: "final class alohaController {}", path: "SomeProject/alohaExampleDir/alohaController.swift"),

            // Second item
            .fileHelperCopy(from: "Package.swift",
                            to: "SomeProject/Package.swift"),
            .fileHelperIsDirCalled(path: "SomeProject/Package.swift"),
            .fileHelperReadFileCalled(path: "SomeProject/Package.swift"),
            .fileHelperWrite(content: "nothing to do here", path: "SomeProject/Package.swift"),

            // Third item
            .fileHelperCopy(from: "__name__Coordinator.swift",
                            to: "SomeProject/__name__Coordinator.swift"),
            .fileHelperMove(from: "SomeProject/__name__Coordinator.swift",
                            to: "SomeProject/alohaCoordinator.swift"),
            .fileHelperIsDirCalled(path: "SomeProject/alohaCoordinator.swift"),
            .fileHelperReadFileCalled(path: "SomeProject/alohaCoordinator.swift"),
            .fileHelperWrite(content: "final class alohaCoordinator {}", path: "SomeProject/alohaCoordinator.swift"),
        ]

        let useCase = GenerateTemplateUseCaseImpl(fileManager: fileHelper)
        useCase.createContent(name: "aloha", template: ControlHelper.getControl1(), templatesDir: "templates/path")

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
