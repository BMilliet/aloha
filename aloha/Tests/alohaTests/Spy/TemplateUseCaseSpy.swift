import Foundation
import XCTest

@testable import aloha

struct TemplateUseCaseSpy: TemplateUseCaseProtocol {

    var methods: MethodsCalled

    var templatesDirReturn = ""
    var userHaveTemplateDirReturn = false
    var isValidTemplateNameReturn = [String: Bool]()
    var getTemplateReturn = [String: TemplateControl?]()
    var listTemplatesReturn = [String]()

    func templatesDir() -> String {
        methods.add(.templateTemplatesDirCalled)
        return templatesDirReturn
    }

    func userHaveTemplateDir() -> Bool {
        methods.add(.templateUserHaveTemplateDirCalled)
        return userHaveTemplateDirReturn
    }

    func listTemplates() -> [String] {
        methods.add(.templateListTemplatesCalled)
        return listTemplatesReturn
    }

    func createAloha() {
        methods.add(.templateCreateAlohaCalled)
    }

    func isValidTemplateName(_ name: String) -> Bool {
        methods.add(.templateIsValidTemplateNameCalled(name))
        do {
            return try XCTUnwrap(isValidTemplateNameReturn[name])
        } catch {
            XCTFail("❌ exist => \(name)")
        }
        return false
    }

    func getTemplate(_ name: String) -> TemplateControl? {
        methods.add(.templateGetTemplateCalled(name))
        do {
            return try XCTUnwrap(getTemplateReturn[name])
        } catch {
            XCTFail("❌ exist => \(name)")
        }
        return nil
    }
}
