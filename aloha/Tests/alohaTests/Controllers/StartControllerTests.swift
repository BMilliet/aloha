import Foundation

import XCTest
@testable import aloha

final class StartControllerTests: XCTestCase {

    func test_when_user_have_templateDir() throws {
        let methodsCalled = MethodsCalled()

        var template = TemplateUseCaseSpy(methods: methodsCalled)

        template.userHaveTemplateDirReturn = true

        let expected: [Methods] = [
            .templateUserHaveTemplateDirCalled
        ]

        let controller = StartController(ui: UISpy(), templateUseCase: template)

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }

    func test_when_user_dont_have_templateDir() throws {
        let methodsCalled = MethodsCalled()

        var template = TemplateUseCaseSpy(methods: methodsCalled)

        template.userHaveTemplateDirReturn = false

        let expected: [Methods] = [
            .templateUserHaveTemplateDirCalled,
            .templateCreateAlohaCalled
        ]

        let controller = StartController(ui: UISpy(), templateUseCase: template)

        controller.start()

        TestHelper.compareEnums(expected: expected, called: methodsCalled.called)
    }
}
