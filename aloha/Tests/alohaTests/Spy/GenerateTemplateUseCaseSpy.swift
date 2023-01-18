import Foundation
import XCTest

@testable import aloha

struct GenerateTemplateUseCaseSpy: GenerateTemplateUseCaseProtocol {

    var methods: MethodsCalled

    func createContent(name: String, template: TemplateControl, templatesDir: String) {
        methods.add(.generateCreateTemplateCalled(name: name, templatesDir: templatesDir))
    }
}
