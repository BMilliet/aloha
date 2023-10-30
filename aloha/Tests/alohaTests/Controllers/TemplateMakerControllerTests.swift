import Foundation

import XCTest
@testable import aloha

final class TemplateMakerControllerTests: XCTestCase {

    func test_happy_path() throws {
        let methodsCalled = MethodsCalled()

        var ui = UISpy()
        var template = TemplateUseCaseSpy(methods: methodsCalled)
        var fileHelper = FileHelperSpy(methods: methodsCalled)

        let sourcePath = "SomeProject/Modules/Feature"

        template.userHaveTemplateDirReturn = false
        template.isValidTemplateNameReturn = ["mvvm": true]
        template.listTemplatesReturn = ["viper"]
        fileHelper.existReturn[sourcePath] = true

        ui.registeredUserInput[
            "Please type the name of the" + Colors.green  +
            " template to be" + Colors.cyan + " created:"
        ] = "mvvm"

        ui.registeredUserInput[
            "Please type the" + Colors.cyan + " path"
            + Colors.reset + " to the source directory that would be the base of the template.\n" +
            "Consider the path relative to where aloha dir is located in you project (usually root dir)"
        ] = sourcePath

        ui.registeredUserInput[
            "Please type the key word that would be considered" +
            Colors.cyan + " dynamic" + Colors.reset + " by the template:"
        ] = "Feature"

        template.userHaveTemplateDirReturn = true

        let expected: [Methods] = [
            .templateUserHaveTemplateDirCalled,
            .templateIsValidTemplateNameCalled("mvvm"),
            .templateListTemplatesCalled,
            .fileHelperExistCalled(path: sourcePath)
        ]

        let controller = TemplateMakerController(ui: ui, templateUseCase: template, fileHelper: fileHelper)

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
