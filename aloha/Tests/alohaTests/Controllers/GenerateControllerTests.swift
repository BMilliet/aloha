import Foundation

import XCTest
@testable import aloha

final class GenerateControllerTests: XCTestCase {

    func testWhenInvalidDir() throws {
        let methodsCalled = MethodsCalled()

        var template = TemplateUseCaseSpy(methods: methodsCalled)
        let generate = GenerateTemplateUseCaseSpy(methods: methodsCalled)

        template.isValidTemplateNameReturn = ["mvvm": false]

        let expected: [Methods] = [
            .templateIsValidTemplateNameCalled("mvvm")
        ]

        let controller = GenerateController(
            name: "Aloha",
            template: "mvvm",
            ui: UISpy(),
            templateUseCase: template,
            generateUseCase: generate
        )

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testWhenUserDontHaveTemplateDir() throws {
        let methodsCalled = MethodsCalled()

        var template = TemplateUseCaseSpy(methods: methodsCalled)
        let generate = GenerateTemplateUseCaseSpy(methods: methodsCalled)

        template.isValidTemplateNameReturn = ["mvvm": true]
        template.userHaveTemplateDirReturn = false

        let expected: [Methods] = [
            .templateIsValidTemplateNameCalled("mvvm"),
            .templateUserHaveTemplateDirCalled
        ]

        let controller = GenerateController(
            name: "Aloha",
            template: "mvvm",
            ui: UISpy(),
            templateUseCase: template,
            generateUseCase: generate
        )

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testWhenUserDontHaveTheSelectedTemplate() throws {
        let methodsCalled = MethodsCalled()

        var template = TemplateUseCaseSpy(methods: methodsCalled)
        let generate = GenerateTemplateUseCaseSpy(methods: methodsCalled)

        template.isValidTemplateNameReturn = ["mvvm": true]
        template.userHaveTemplateDirReturn = true
        template.getTemplateReturn = ["mvvm": nil]

        let expected: [Methods] = [
            .templateIsValidTemplateNameCalled("mvvm"),
            .templateUserHaveTemplateDirCalled,
            .templateGetTemplateCalled("mvvm")
        ]

        let controller = GenerateController(
            name: "Aloha",
            template: "mvvm",
            ui: UISpy(),
            templateUseCase: template,
            generateUseCase: generate
        )

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func testHappyPath() throws {
        let methodsCalled = MethodsCalled()

        var template = TemplateUseCaseSpy(methods: methodsCalled)
        let generate = GenerateTemplateUseCaseSpy(methods: methodsCalled)

        template.isValidTemplateNameReturn = ["mvvm": true]
        template.userHaveTemplateDirReturn = true
        template.getTemplateReturn = ["mvvm": ControlHelper.getControl1()]
        template.templatesDirReturn = "somePath"

        let expected: [Methods] = [
            .templateIsValidTemplateNameCalled("mvvm"),
            .templateUserHaveTemplateDirCalled,
            .templateGetTemplateCalled("mvvm"),
            .templateTemplatesDirCalled,
            .generateCreateTemplateCalled(name: "Aloha", templatesDir: "somePath")
        ]

        let controller = GenerateController(
            name: "Aloha",
            template: "mvvm",
            ui: UISpy(),
            templateUseCase: template,
            generateUseCase: generate
        )

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
